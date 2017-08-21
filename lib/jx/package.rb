require 'erb'

Jx::HEADER_ERB = ERB.new <<-'HEADER'
#include <string>

<% functions.each do |_, func| %>
<%= func.to_h %>
<% end %>
HEADER

Jx::CPP_ERB = ERB.new <<-'CPP'
// #include "<%= name %>.h"

<% functions.each do |_, func| %>
<%= func.to_cpp %>
<% end %>
CPP

module Jx
  class Package
    attr_accessor :name, :functions

    def initialize(name)
      @name = name
      @functions = {}
    end

    def to_h
      HEADER_ERB.result(binding)
    end

    def to_cpp
      CPP_ERB.result(binding)
    end
  end
end
