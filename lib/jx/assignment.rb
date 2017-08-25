module Jx
  class Assignment
    attr_accessor :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def each_descendant(&block)
      right.each_descendant &block
      yield right

      left.each_descendant &block
      yield left
    end

    def to_cpp
      "#{left.to_cpp} = #{right.to_cpp}"
    end
  end
end
