module Jx
  class Package
    attr_accessor :name, :functions, :symbol_table

    def initialize(name)
      @name = name
      @functions = {}
      @symbol_table = {}
    end

    def register_function(fn_def)
      symbol_table[fn_def.name] = fn_def
      functions[fn_def.name] = fn_def
    end

    def register_variable(var_decl)
      symbol_table[var_decl.name] = var_decl
    end
  end
end
