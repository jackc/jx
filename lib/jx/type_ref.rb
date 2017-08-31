require 'erb'

module Jx
  class TypeRef
    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def each_descendant(&block)
    end

    def analyze(context)
    end

    def to_cpp
      case name
      when "string"
        "std::string"
      when "int"
        "int64_t"
      else
        name
      end
    end
  end
end
