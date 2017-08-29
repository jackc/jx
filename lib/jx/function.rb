require 'erb'

module Jx
  class Function
    attr_accessor :name, :parameters, :stmt_list, :return_type

    def initialize(name, parameters, stmt_list, return_type)
      @name = name
      @parameters = parameters
      @stmt_list = stmt_list
      @return_type = return_type || "void"
    end

    def each_descendant(&block)
      parameters.each do |p|
        p.each_descendant &block
        yield p
      end

      stmt_list.each_descendant &block
      yield stmt_list
    end

    def to_h
      "#{signature};"
    end

    def to_def
      "#{signature} {\n    #{stmt_list.to_cpp}\n}"
    end

    def to_cpp
      ""
    end

  private
    def signature
      "#{return_type} #{name}(#{parameters.map(&:to_cpp).join(", ")})"
    end
  end
end
