require 'erb'

module Jx
  class FnParam
    attr_accessor :name, :type

    def initialize(name, type)
      @name = name
      @type = type
    end

    def each_descendant(&block)
    end

    def to_cpp
      cpptype = case type
      when "string"
        "std::string"
      when "int"
        "int"
      end
      "#{cpptype} #{@name.to_cpp}"
    end
  end
end
