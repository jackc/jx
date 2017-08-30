require 'erb'

module Jx
  # SymbolGet is typically a variable access. But it could also be a function value or constant.
  class SymbolGet
    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def each_descendant(&block)
    end

    def analyze(context)
      unless context.find_symbol(name)
        line, column = name.line_and_column
        raise "Cannot find symbol #{name} at line #{line} column #{column}"
      end
    end

    def to_cpp
      @name
    end
  end
end
