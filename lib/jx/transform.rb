require 'parslet'

module Jx
  class Transform < Parslet::Transform
    rule(:stripped => simple(:x)) { x }
    rule(:ident => simple(:x)) { Ident.new x }
    rule(:string => simple(:x)) { StringLiteral.new x }
    rule(:integer => simple(:x)) { IntegerLiteral.new x }
    rule(:fn_name => simple(:fn_name)) { FnCall.new(fn_name, []) }
    rule(:fn_name => simple(:fn_name), :args => simple(:args)) { FnCall.new(fn_name, [args]) }
    rule(:fn_name => simple(:fn_name), :args => sequence(:args)) { FnCall.new(fn_name, args) }
    rule(:stmt_list => sequence(:stmt_list)) { StmtList.new(stmt_list) }
    rule(:stmt => simple(:x)) { Stmt.new x }
    rule(var_decl: simple(:x), ident: simple(:ident), type: simple(:type)) { VarDecl.new ident, type }
    rule(left: simple(:left), assign: simple(:m), right: simple(:right)) { Assignment.new left, right }
    rule(l: simple(:l), o: simple(:o), r: simple(:r)) { InfixCall.new l, o, r }
    rule(while_cond: simple(:cond), stmt_list: sequence(:stmt_list)) { WhileLoop.new cond, StmtList.new(stmt_list) }
    rule(if_cond: simple(:cond), stmt_list: sequence(:stmt_list)) { If.new cond, StmtList.new(stmt_list) }
    rule(fn_def: simple(:fn), ident: simple(:ident), params: simple(:none), stmt_list: sequence(:stmt_list)) { FnDef.new ident, [], StmtList.new(stmt_list), nil }
    rule(fn_def: simple(:fn), ident: simple(:ident), params: sequence(:params), stmt_list: sequence(:stmt_list)) { FnDef.new ident, params, StmtList.new(stmt_list), nil }
    rule(fn_def: simple(:fn), ident: simple(:ident), params: sequence(:params), return_type: simple(:return_type), stmt_list: sequence(:stmt_list)) { FnDef.new ident, params, StmtList.new(stmt_list), return_type }
    rule(fn_param: simple(:fn_param), type: simple(:type)) { FnParam.new fn_param, type }
    rule(fn_return: simple(:x), value: simple(:value)) { FnReturn.new value }
  end
end
