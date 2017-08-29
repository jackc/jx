require 'erb'

module Jx
  class FnReturn
    attr_accessor :expr

    def initialize(expr)
      @expr = expr
    end

    def each_descendant(&block)
      if expr
        expr.each_descendant &block
        yield expr
      end
    end

    def to_cpp
      if expr
        "return #{expr.to_cpp}"
      else
        "return"
      end
    end
  end
end
