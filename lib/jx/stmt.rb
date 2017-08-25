module Jx
  Stmt = Struct.new(:stmt) do
    def each_descendant(&block)
      stmt.each_descendant &block
      yield stmt
    end

    def to_cpp
      "#{stmt.to_cpp};"
    end
  end
end
