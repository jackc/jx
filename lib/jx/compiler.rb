require 'erb'

require_relative 'parser'
require_relative 'transform'
require 'pp'

module Jx
  class Compiler
    @@builtin = <<-'JX'
fn puts(s string)
  __cpp
    std::cout << s;
  cpp__
end

fn puti(i int)
  __cpp
    std::cout << i;
  cpp__
end

fn gets -> string
  var s string
  __cpp
    std::cin >> s;
  cpp__
  return s
end
JX

    def initialize(src)
      @src = src
    end

    def to_cpp
      intermediary_tree = Parser.new.parse(@@builtin + @src)
      abstract_tree = Transform.new.apply(intermediary_tree)

      # require 'pry'; binding.pry
      if ENV['JX_DEBUG']
        pp abstract_tree
      end

      context = Package.new 'main'
      context.require_header 'iostream'
      context.require_header 'cstdint'

      abstract_tree.analyze(context)

      # require 'pry'; binding.pry

      # pp context.symbol_table

  cpp = ERB.new <<-'CPP'
<% context.headers.each do |h| %>
#include <<%= h %>>
<% end %>

namespace jx {
<% context.functions.each do |f| %>
<%= f.to_h %>
<% end %>

<% context.functions.each do |f| %>
<%= f.to_def %>
<% end %>
}

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
