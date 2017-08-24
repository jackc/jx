require 'minitest/autorun'
require "minitest/parallel"

class IntegrationTest < Minitest::Test
  parallelize_me!

  def jxc(args="")
    `jxc #{args}`
  end

  def run_jx(jx_source_path)
    cpp_source_path = jx_source_path.sub(/jx$/, "cpp")
    jxc "-o #{cpp_source_path} #{jx_source_path}"

    bin_path = cpp_source_path.sub(/\.cpp$/, "")
    `g++ -g -Wall -Werror -O3 -o #{bin_path} #{cpp_source_path}`

    `#{bin_path}`
  end
end
