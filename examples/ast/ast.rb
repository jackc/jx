require 'jx'

pkg = Jx::Package.new "util"
pkg.functions["greet"] = Jx::Function.new(
  "greet",
  [
    Jx::Parameter.new("name", Jx::TypeRef.new("std::string"))
  ],
  Jx::ExprList.new(
    [
      Jx::FnCall.new("puts", [Jx::Variable.new("name")]),
    ]
  )
)

Jx::FnCall.new("greet", []).to_cpp

ast = Jx::ExprList.new(
  [
    Jx::FnCall.new("puts", [Jx::StringLiteral.new("Hello, world")]),
    Jx::FnCall.new("puts", [Jx::StringLiteral.new("Goodbye, world")]),
    Jx::FnCall.new("greet", [Jx::StringLiteral.new("Jack")]),
  ]
)


cpp = ERB.new <<-'CPP'
#include <iostream>
#include <string>

<%= pkg.to_h %>

int main() {
  <%= ast.to_cpp %>
}

<%= pkg.to_cpp %>
CPP

puts cpp.result(binding)
