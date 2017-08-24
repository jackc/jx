require 'parslet'

module Jx
  class Parser < Parslet::Parser
    root :stmt_list

    rule :stmt_list do
      stmt.repeat(1).as(:stmt_list)
    end

    rule :stmt do
      (
        var_decl |
        expr
      ).as(:stmt) >> eol
    end

    def strip atom
      space.repeat >> atom.as(:stripped) >> space.repeat
    end

    rule(:mul_op) { strip match['*/'] }
    rule(:add_op) { strip match['+-'] }

    rule :expr do
      infix_expr |
      simple_expr
    end

    rule :infix_expr do
      infix_expression(simple_expr,
        [mul_op, 2, :left],
        [add_op, 1, :right]
      )
    end

    rule :simple_expr do
      (
        fn_call |
        assignment |
        string |
        integer |
        ident
      )
    end

    rule :fn_call do
      ident.as(:name) >> str('(') >> expr.as(:arg) >> str(')')
    end

    rule :var_decl do
      str('var') >> space >> ident >> space >> match['a-z'].repeat(1).as(:type)
    end

    rule :assignment do
      ident.as(:left) >> space >> str('=').as(:assign) >> space >> expr.as(:right)
    end

    rule :ident do
      match['a-z'].repeat.as(:ident)
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
