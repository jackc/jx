require 'erb'

module Jx
  class If
    attr_accessor :cond, :stmt_list

    def initialize(cond, stmt_list)
      @cond = cond
      @stmt_list = stmt_list
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
