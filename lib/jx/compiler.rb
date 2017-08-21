require 'erb'

require_relative 'parser'
require_relative 'transform'

module Jx
  class Compiler
    def initialize(src)
      @src = src
    end

    def to_cpp
      intermediary_tree = Parser.new.parse(@src)
      abstract_tree = Transform.new.apply(intermediary_tree)

  cpp = ERB.new <<-'CPP'
  #include <iostream>

  int main() {
    <%= abstract_tree.to_cpp %>
  }
  CPP

      cpp.result(binding)
    end
  end
end
