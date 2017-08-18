require 'erb'

require_relative 'parser'
require_relative 'transform'

class JxCompiler
  def initialize(src)
    @src = src
  end

  def to_cpp
    intermediary_tree = JxParser.new.parse(@src)
    abstract_tree = JxTransform.new.apply(intermediary_tree)

cpp = ERB.new <<-'CPP'
#include <iostream>

int main() {
  <%= abstract_tree.to_cpp %>
}
CPP

    cpp.result(binding)
  end
end
