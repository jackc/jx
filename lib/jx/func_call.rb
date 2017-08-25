require 'erb'

module Jx
  class FuncCall
    attr_accessor :name, :arguments

    def initialize(name, arguments)
      @name = name
      @arguments = arguments
    end

    def each_descendant(&block)
      arguments.each do |a|
        a.each_descendant &block
        yield a
      end
    end

    def to_cpp
      "#{name.to_cpp}(#{arguments.map(&:to_cpp).join(", ")})"
    end
  end
end
