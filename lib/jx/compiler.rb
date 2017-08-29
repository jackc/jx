require 'erb'

require_relative 'parser'
require_relative 'transform'
# require 'pp'

module Jx
  class Compiler
    def initialize(src)
      @src = src
    end

    def to_cpp
      intermediary_tree = Parser.new.parse(@src)
      abstract_tree = Transform.new.apply(intermediary_tree)

      # require 'pry'; binding.pry

      # pp abstract_tree

      functions = {}
      symbol_table = {}
      abstract_tree.each_descendant do |node|
        if node.kind_of? Jx::VarDecl
          symbol_table[node.name] = node
        end
        if node.kind_of? Jx::FnDef
          symbol_table[node.name] = node
          functions[node.name] = node
        end
      end

      # p symbol_table

      # p abstract_tree

      # require 'pry'; binding.pry

  cpp = ERB.new <<-'CPP'
#include <iostream>

<% functions.each do |_, f| %>
<%= f.to_h %>
<% end %>

<% functions.each do |_, f| %>
<%= f.to_def %>
<% end %>

int main() {
  <%= abstract_tree.to_cpp %>
}
  CPP

      cpp.result(binding)

 rescue Parslet::ParseFailed => error
    puts error.parse_failure_cause.ascii_tree

    end
  end
end
