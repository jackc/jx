require 'parslet'

class JxParser < Parslet::Parser
  root :expr

  rule(:expr) { fn_call >> eol }

  rule(:fn_call) {
    ident.as(:name) >> str('(') >> string.as(:arg) >> str(')')
  }

  rule(:ident) {
    match['a-z'].repeat
  }

  rule :string {
    str('"') >>
    (
      (str('\\') >> any) |
      (str('"').absent? >> any)
    ).repeat.as(:string) >>
    str('"')
  }

  rule :space {
    (match '[ ]').repeat(1)
  }

  rule :eol {
    line_end.repeat(1)
  }

  rule :line_end {
    crlf >> space.maybe
  }

  rule :crlf {
    match('[\r\n]').repeat(1)
  }
end
