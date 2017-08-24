require 'parslet'

module Jx
  class Transform < Parslet::Transform
    rule(:ident => simple(:x)) { Ident.new x }
    rule(:string => simple(:x)) { StringLiteral.new x }
    rule(:name => simple(:name), :arg => simple(:arg)) { FuncCall.new(name, [arg]) }
    rule(:stmt_list => sequence(:stmt_list)) { StmtList.new(stmt_list) }
    rule(:stmt => simple(:x)) { Stmt.new x }
    rule(:var_decl => simple(:x)) { VarDecl.new x }
    rule(left: simple(:left), assign: simple(:m), right: simple(:right)) { Assignment.new left, right }
  end
end
