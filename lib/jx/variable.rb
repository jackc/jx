require 'erb'

module Jx
  class Variable
    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def to_cpp
      @name
    end
  end
end
