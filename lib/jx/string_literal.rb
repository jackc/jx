require 'parslet'

module Jx
  StringLiteral = Struct.new(:value) do
    def to_cpp
      value.to_s.inspect
    end
  end
end
