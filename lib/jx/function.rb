require 'erb'

module Jx
  class Function
    attr_accessor :name, :parameters, :expr_list

    def initialize(name, parameters, expr_list)
      @name = name
      @parameters = parameters
      @expr_list = expr_list
    end

    def to_h
      "#{signature};"
    end

    def to_cpp
      "#{signature} {\n    #{expr_list.to_cpp}\n}"
    end

  private
    def signature
      "void #{name}(#{parameters.map(&:to_cpp).join(", ")})"
    end
  end
end
