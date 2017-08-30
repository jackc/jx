module Jx
  class Package
    attr_accessor :name, :scope

    def initialize(name)
      @name = name
      @scope = Scope.new nil
    end

    def register_symbol(node)
      scope.register_symbol(node)
    end

    def find_symbol(name)
      scope.find_symbol(name)
    end

    def new_child_scope
      scope.new_child_scope
    end

    def functions
      scope.symbol_table.select { |_, v| v.kind_of?(FnDef) }.map { |_, v| v }
    end

  end
end
