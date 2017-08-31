module Jx
  class VarDecl
    attr_accessor :name, :type

    def initialize(name, type)
      @name = name
      @type = type
    end

    def each_descendant(&block)
    end

    def analyze(context)
      context.register_symbol(self)
    end

    def to_cpp
      "#{type.to_cpp} #{@name}"
    end
  end
end
