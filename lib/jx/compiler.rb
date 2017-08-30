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

      context = Package.new 'main'

      abstract_tree.analyze(context)

      # p symbol_table
      # p abstract_tree
      # require 'pry'; binding.pry

  cpp = ERB.new <<-'CPP'
#include <iostream>

<% context.functions.each do |_, f| %>
<%= f.to_h %>
<% end %>

<% context.functions.each do |_, f| %>
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
