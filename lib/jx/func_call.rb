require 'erb'

module Jx
  class FuncCall
    attr_accessor :name, :arguments

    def initialize(name, arguments)
      @name = name
      @arguments = arguments
    end

    def to_cpp
      "#{name.to_cpp}(#{arguments.map(&:to_cpp).join(", ")});"
    end
  end
end
