require 'parslet'

module Jx
  class Parser < Parslet::Parser
    root :expr_list

    rule :expr_list do
      expr.repeat(1).as(:expr_list)
    end

    rule :expr do
      fn_call >> eol
    end

    rule :fn_call do
      ident.as(:name) >> str('(') >> string.as(:arg) >> str(')')
    end

    rule :ident do
      match['a-z'].repeat
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
