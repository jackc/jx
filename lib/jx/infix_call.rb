module Jx
  class InfixCall
    attr_accessor :left, :op, :right

    def initialize(left, op, right)
      @left = left
      @op = op
      @right = right
    end

    def to_cpp
      "#{left.to_cpp} #{op} #{right.to_cpp}"
    end
  end
end
