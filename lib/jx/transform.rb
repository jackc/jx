require 'parslet'

module Jx
  class Transform < Parslet::Transform
    rule(:stripped => simple(:x)) { x }
    rule(:ident => simple(:x)) { Ident.new x }
    rule(:string => simple(:x)) { StringLiteral.new x }
    rule(:integer => simple(:x)) { IntegerLiteral.new x }
    rule(:name => simple(:name), :arg => simple(:arg)) { FuncCall.new(name, [arg]) }
    rule(:stmt_list => sequence(:stmt_list)) { StmtList.new(stmt_list) }
    rule(:stmt => simple(:x)) { Stmt.new x }
    rule(ident: simple(:ident), type: simple(:type)) { VarDecl.new ident, type }
    rule(left: simple(:left), assign: simple(:m), right: simple(:right)) { Assignment.new left, right }
    rule(l: simple(:l), o: simple(:o), r: simple(:r)) { InfixCall.new l, o, r }
    rule(while_cond: simple(:cond), stmt_list: sequence(:stmt_list)) { WhileLoop.new cond, StmtList.new(stmt_list) }
    rule(if_cond: simple(:cond), stmt_list: sequence(:stmt_list)) { If.new cond, StmtList.new(stmt_list) }
  end
end
