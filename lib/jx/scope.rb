module Jx
  class Scope
    attr_accessor :parent, :symbol_table

    def initialize(parent)
      @parent = parent
      @symbol_table = {}
    end

    def register_symbol(node)
      symbol_table[node.name.to_s] = node
    end

    def find_symbol(name)
      symbol_table[name.to_s]
    end

    def new_child_scope
      self.class.new(self)
    end
  end
end
