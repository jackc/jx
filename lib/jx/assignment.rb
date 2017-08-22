module Jx
  class Assignment
    attr_accessor :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    def to_cpp
      "#{left.to_cpp} = #{right.to_cpp};"
    end
  end
end
