require 'parslet'

module Jx
  class Parser < Parslet::Parser
    root :stmt_list

    rule :stmt_list do
      stmt.repeat(1).as(:stmt_list)
    end

    rule :stmt do
      expr.as(:stmt) >> eol
    end

    rule :expr do
      (
        fn_call |
        var_decl |
        assignment
      )
    end

    rule :fn_call do
      ident.as(:name) >> str('(') >> (string | ident).as(:arg) >> str(')')
    end

    rule :var_decl do
      (str('var') >> space >> ident).as(:var_decl)
    end

    rule :assignment do
      ident.as(:left) >> space >> str('=').as(:assign) >> space >> (string | ident).as(:right)
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
