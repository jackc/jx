require 'parslet'

module Jx
  class Parser < Parslet::Parser
    root :stmt_list

    rule :stmt_list do
      stmt.repeat(1).as(:stmt_list)
    end

    rule :stmt do
      (
        while_loop |
        if_a |
        var_decl |
        fn_def |
        expr |
        fn_return |
        raw_cpp
      ).as(:stmt) >> eol
    end

    def strip atom
      space.repeat >> atom.as(:stripped) >> space.repeat
    end

    rule(:mul_op) { strip match['*/'] }
    rule(:add_op) { strip match['+-'] }
    rule(:comp_op) { strip match['<>'] }

    rule :expr do
      infix_expr |
      simple_expr
    end

    rule :infix_expr do
      infix_expression(simple_expr,
        [mul_op, 3, :left],
        [add_op, 2, :left],
        [comp_op, 1, :left]
      )
    end

    rule :simple_expr do
      (
        fn_call |
        assignment |
        string |
        integer |
        symbol_get
      )
    end

    rule :symbol_get do
      ident.as(:symbol_get)
    end

    rule :fn_call do
      ident.as(:fn_name) >> str('()') |
      ident.as(:fn_name) >> str('(') >>
        (expr >> (str(', ') >> expr).repeat).maybe.as(:args) >>
      str(')')
    end

    rule :var_decl do
      str('var').as(:var_decl) >> space >> ident.as(:name) >> space >> match['a-z'].repeat(1).as(:type)
    end

    rule :assignment do
      ident.as(:left) >> space >> str('=').as(:assign) >> space >> expr.as(:right)
    end

    rule :while_loop do
      str('while') >> space >> expr.as(:while_cond) >> line_end >>
        stmt_list >>
      str('end')
    end

    rule :fn_def do
      str('fn').as(:fn_def) >> space >> ident.as(:name) >>
      (str('(') >> fn_param.repeat >> str(')')).maybe.as(:params) >>
      (space >> str('->') >> space >> match['a-z'].repeat(1).as(:return_type)).maybe >>
      line_end >>
        stmt_list >>
      str('end')
    end

    rule :fn_param do
      ident.as(:fn_param) >> space >> match['a-z'].repeat(1).as(:type)
    end

    rule :fn_return do
      str('return').as(:fn_return) >> space >> expr.maybe.as(:value)
    end

    # if_a instead of if because if is already Ruby keyword
    rule :if_a do
      str('if') >> space >> expr.as(:if_cond) >> line_end >>
        stmt_list >>
      str('end')
    end

    rule :ident do
      keyword.absent? >> match['a-z'].repeat
    end

    rule :raw_cpp do
      str('__cpp') >>
      (str('cpp__').absent? >> any).repeat.as(:raw_cpp) >>
      str('cpp__')
    end

    rule :keyword do
      str('while') |
      str('end') |
      str('if') |
      str('return') |
      str('__cpp') |
      str('cpp__')
    end

    rule :string do
      str('"') >>
      (
        (str('\\') >> any) |
        (str('"').absent? >> any)
      ).repeat.as(:string) >>
      str('"')
    end

    rule :space do
      (match '[ ]').repeat(1)
    end

    rule(:integer) { strip digit.repeat(1).as(:integer) }
    rule(:digit) { match['0-9'] }

    rule :eol do
      line_end.repeat(1)
    end

    rule :line_end do
      crlf >> space.maybe
    end

    rule :crlf do
      match('[\r\n]').repeat(1)
    end
  end
end
