require 'parslet'

module Jx
  class Transform < Parslet::Transform
    rule(:string => simple(:x)) { StringLiteral.new x }
    rule(:name => simple(:name), :arg => simple(:arg)) { FuncCall.new(name, [arg]) }
    rule(:expr_list => sequence(:expr_list)) { ExprList.new(expr_list) }
  end
end
