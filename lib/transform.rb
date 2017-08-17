require 'parslet'

StringLiteral = Struct.new(:value) do
  def to_cpp
    value.to_s.inspect
  end
end

FnCall = Struct.new(:name, :arg) do
  def to_cpp
    "#{subbed_name}(#{arg.to_cpp});"
  end

  private

  def subbed_name
    n = name.to_s
    {
      "puts" => "std::cout<<"
    }.fetch(n, n)
  end
end

class JxTransform < Parslet::Transform
  rule(:string => simple(:x)) { StringLiteral.new x }
  rule(:name => simple(:name), :arg => simple(:arg)) { FnCall.new(name, arg) }
end
