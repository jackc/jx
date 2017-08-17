require 'erb'

require_relative 'lib/parser'
require_relative 'lib/transform'

src = ARGF.read

intermediary_tree = JxParser.new.parse(src)
abstract_tree = JxTransform.new.apply(intermediary_tree)

cpp = ERB.new <<-'CPP'
#include <iostream>

int main() {
  <%= abstract_tree.to_cpp %>
}
CPP

puts cpp.result(binding)
