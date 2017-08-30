module Jx
  class InfixCall
    attr_accessor :left, :op, :right

    def initialize(left, op, right)
      @left = left
      @op = op
      @right = right
    end

    def each_descendant(&block)
      left.each_descendant &block
      yield left

      right.each_descendant &block
      yield right
    end

    def analyze(context)
      left.analyze(context)
      right.analyze(context)
    end

    def to_cpp
      "#{left.to_cpp} #{op} #{right.to_cpp}"
    end
  end
end
