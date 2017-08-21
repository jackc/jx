module Jx
  ExprList = Struct.new(:expr_list) do
    def to_cpp
      expr_list.map(&:to_cpp).join("\n")
    end
  end
end
