module Jx
  StmtList = Struct.new(:stmt_list) do
    def each_descendant(&block)
      stmt_list.each do |s|
        s.each_descendant &block
        yield s
      end
    end

    def to_cpp
      stmt_list.map(&:to_cpp).join("\n")
    end
  end
end
