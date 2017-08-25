module Jx
  class Ident
    attr_accessor :name

    def initialize(name)
      @name = name

      if @name == "puts"
        @name = "std::cout<<"
      end

      if @name == "gets"
        @name = "std::cin>>"
      end
    end

    def each_descendant(&block)
    end

    def to_cpp
      @name
    end
  end
end
