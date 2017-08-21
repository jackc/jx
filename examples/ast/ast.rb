require 'jx'

pkg = Jx::Package.new "util"
pkg.functions["greet"] = Jx::Function.new(
  "greet",
  nil,
  ExprList.new(
    [
      FnCall.new("puts", StringLiteral.new("Greetings")),
    ]
  )
)

Jx::FuncCall.new("greet", []).to_cpp

ast = ExprList.new(
  [
    FnCall.new("puts", StringLiteral.new("Hello, world")),
    FnCall.new("puts", StringLiteral.new("Goodbye, world")),
    Jx::FuncCall.new("greet", []),
  ]
)


cpp = ERB.new <<-'CPP'
#include <iostream>

<%= pkg.to_h %>

int main() {
  <%= ast.to_cpp %>
}

<%= pkg.to_cpp %>
CPP

puts cpp.result(binding)
