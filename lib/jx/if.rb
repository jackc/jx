require 'erb'

module Jx
  class If
    attr_accessor :cond, :stmt_list

    def initialize(cond, stmt_list)
      @cond = cond
      @stmt_list = stmt_list
    end

    def each_descendant(&block)
      cond.each_descendant &block
      yield cond

      stmt_list.each_descendant &block
      yield stmt_list
    end

    def analyze(context)
      cond.analyze(context)
      stmt_list.analyze(context)
    end

    def to_cpp
      <<-CPP
if(#{@cond.to_cpp}) {
  #{@stmt_list.to_cpp}
}
CPP
    end
  end
end
