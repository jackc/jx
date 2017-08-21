require 'parslet'

module Jx
  ExprList = Struct.new(:expr_list) do
    def to_cpp
      expr_list.map(&:to_cpp).join("\n")
    end
  end

  StringLiteral = Struct.new(:value) do
    def to_cpp
      value.to_s.inspect
    end
  end

  class Transform < Parslet::Transform
    rule(:string => simple(:x)) { StringLiteral.new x }
    rule(:name => simple(:name), :arg => simple(:arg)) { FuncCall.new(name, [arg]) }
    rule(:expr_list => sequence(:expr_list)) { ExprList.new(expr_list) }
  end
end
