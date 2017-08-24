module Jx
  class VarDecl
    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def to_cpp
      "std::string #{@name.to_cpp}"
    end
  end
end
