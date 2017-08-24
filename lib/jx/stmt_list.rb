module Jx
  StmtList = Struct.new(:stmt_list) do
    def to_cpp
      stmt_list.map(&:to_cpp).join("\n")
    end
  end
end
