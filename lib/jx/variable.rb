require 'erb'

module Jx
  class Variable
    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def each_descendant(&block)
    end

    def analyze(context)
    end

    def to_cpp
      @name
    end
  end
end
