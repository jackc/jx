require 'parslet'

ExprList = Struct.new(:expr_list) do
  def to_cpp
    expr_list.map(&:to_cpp).join("\n")
  end
end

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

Fn = Struct.new(:name, :parameters, :expr_list) do
  def to_cpp
    <<-CPP
void #{name}(#{converted_parameters.join(",")}) {
    #{expr_list}
}
CPP
  end

  private

  def converted_parameters
    parameters.map { |p| "std::string #{p}" }
  end
end

class JxTransform < Parslet::Transform
  rule(:string => simple(:x)) { StringLiteral.new x }
  rule(:name => simple(:name), :arg => simple(:arg)) { FnCall.new(name, arg) }
  rule(:expr_list => sequence(:expr_list)) { ExprList.new(expr_list) }
end
