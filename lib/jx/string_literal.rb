require 'parslet'

module Jx
  class StringLiteral
    attr_accessor :value

    def initialize(value)
      @value = value
    end

    def each_descendant(&block)
    end

    def analyze(context)
    end

    def to_cpp
      %Q["#{value.to_s.gsub('"', '\"')}"]
    end
  end
end
