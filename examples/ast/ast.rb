require 'jx'

pkg = Jx::Package.new "util"
pkg.functions["greet"] = Jx::Function.new(
  "greet",
  nil,
  Jx::ExprList.new(
    [
      Jx::FuncCall.new("puts", [Jx::StringLiteral.new("Greetings")]),
    ]
  )
)

Jx::FuncCall.new("greet", []).to_cpp

ast = Jx::ExprList.new(
  [
    Jx::FuncCall.new("puts", [Jx::StringLiteral.new("Hello, world")]),
    Jx::FuncCall.new("puts", [Jx::StringLiteral.new("Goodbye, world")]),
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
