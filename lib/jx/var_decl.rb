module Jx
  class VarDecl
    attr_accessor :name, :type

    def initialize(name, type)
      @name = name
      @type = type
    end

    def to_cpp
      cpptype = case type
      when "string"
        "std::string"
      when "int"
        "int"
      end
      "#{cpptype} #{@name}"
    end
  end
end
