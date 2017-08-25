require 'parslet'

module Jx
  StringLiteral = Struct.new(:value) do
    def each_descendant(&block)
    end

    def to_cpp
      value.to_s.inspect
    end
  end
end
