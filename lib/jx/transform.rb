require 'parslet'

module Jx
  class Transform < Parslet::Transform
    rule(:stripped => simple(:x)) { x }
    rule(:symbol_get => simple(:x)) { SymbolGet.new x }
    rule(:type_name => simple(:x)) { TypeRef.new x }
    rule(:string => simple(:x)) { StringLiteral.new x }
    rule(:integer => simple(:x)) { IntegerLiteral.new x }
    rule(:fn_name => simple(:fn_name)) { FnCall.new(fn_name, []) }
    rule(:fn_name => simple(:fn_name), :args => simple(:args)) { FnCall.new(fn_name, [args]) }
    rule(:fn_name => simple(:fn_name), :args => sequence(:args)) { FnCall.new(fn_name, args) }
    rule(:stmt_list => sequence(:stmt_list)) { StmtList.new(stmt_list) }
    rule(:stmt => simple(:x)) { Stmt.new x }
    rule(var_decl: simple(:x), name: simple(:name), type: simple(:type)) { VarDecl.new name, type }
    rule(left: simple(:left), assign: simple(:m), right: simple(:right)) { Assignment.new left, right }
    rule(l: simple(:l), o: simple(:o), r: simple(:r)) { InfixCall.new l, o, r }
    rule(while_cond: simple(:cond), stmt_list: sequence(:stmt_list)) { WhileLoop.new cond, StmtList.new(stmt_list) }
    rule(if_cond: simple(:cond), stmt_list: sequence(:stmt_list)) { If.new cond, StmtList.new(stmt_list) }
    rule(fn_def: simple(:fn), name: simple(:name), params: simple(:none), stmt_list: sequence(:stmt_list)) { FnDef.new name, [], StmtList.new(stmt_list), nil }
    rule(fn_def: simple(:fn), name: simple(:name), params: sequence(:params), stmt_list: sequence(:stmt_list)) { FnDef.new name, params, StmtList.new(stmt_list), nil }
    rule(fn_def: simple(:fn), name: simple(:name), params: sequence(:params), return_type: simple(:return_type), stmt_list: sequence(:stmt_list)) { FnDef.new name, params, StmtList.new(stmt_list), return_type }
    rule(fn_param: simple(:fn_param), type: simple(:type)) { FnParam.new fn_param, type }
    rule(fn_return: simple(:x), value: simple(:value)) { FnReturn.new value }
    rule(raw_cpp: simple(:x)) { RawCpp.new x }
  end
end
