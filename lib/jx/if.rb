require 'erb'

module Jx
  class If
    attr_accessor :cond, :if_block, :else_block

    def initialize(cond, if_block, else_block)
      @cond = cond
      @if_block = if_block
      @else_block = else_block
    end

    def each_descendant(&block)
      cond.each_descendant &block
      yield cond

      if_block.each_descendant &block
      yield if_block
    end

    def analyze(context)
      cond.analyze(context)
      if_block.analyze(context)
    end

    def to_cpp
      s = <<-CPP
if(#{@cond.to_cpp}) {
  #{@if_block.to_cpp}
}
CPP

      if else_block
        s += <<-CPP
else {
  #{@else_block.to_cpp}
}
CPP
      end

      s
    end
  end
end
