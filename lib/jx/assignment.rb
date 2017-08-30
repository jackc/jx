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
    end

    def analyze(context)
      right.analyze(context)
    end

    def to_cpp
      "#{left} = #{right.to_cpp}"
    end
  end
end
