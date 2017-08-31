require 'erb'

module Jx
  class RawCpp
    attr_accessor :src

    def initialize(src)
      @src = src
    end

    def each_descendant(&block)
    end

    def analyze(context)
    end

    def to_cpp
      @src
    end
  end
end
