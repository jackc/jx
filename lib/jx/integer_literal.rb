require 'parslet'

module Jx
  IntegerLiteral = Struct.new(:value) do
    def to_cpp
      value.to_s
    end
  end
end
