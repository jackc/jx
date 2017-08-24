module Jx
  Stmt = Struct.new(:stmt) do
    def to_cpp
      "#{stmt.to_cpp};"
    end
  end
end
