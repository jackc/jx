require 'parslet'

module Jx
  class Transform < Parslet::Transform
    rule(:ident => simple(:x)) { Ident.new x }
    rule(:string => simple(:x)) { StringLiteral.new x }
    rule(:name => simple(:name), :arg => simple(:arg)) { FuncCall.new(name, [arg]) }
    rule(:expr_list => sequence(:expr_list)) { ExprList.new(expr_list) }
    rule(:var_decl => simple(:x)) { VarDecl.new x }
    rule(left: simple(:left), assign: simple(:m), right: simple(:right)) { Assignment.new left, right }
  end
end
