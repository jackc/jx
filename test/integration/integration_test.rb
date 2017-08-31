require_relative '../test_helper'

require 'open3'

class IntegrationTest < Minitest::Test
  parallelize_me!

  jx_source_paths = Dir.glob(File.join(__dir__, "*.jx"))
  tmp_path = File.join(__dir__, '..', '..', 'tmp')

  jx_source_paths.each do |jx_source_path|
    test_name = File.basename(jx_source_path).sub(/\.jx$/, "")
    expected_stdout = File.read(jx_source_path.sub(/jx$/, "out"))

    define_method "test_#{test_name}" do
      cpp_source_path = File.join(tmp_path, "#{test_name}.cpp")
      assert system("jxc", "-o", cpp_source_path, jx_source_path)

      bin_path = cpp_source_path.sub(/\.cpp$/, "")
      assert system("g++", "-std=c++17", "-g", "-Wall", "-Werror", "-O3", "-o", bin_path, cpp_source_path)

      Open3.popen3(bin_path) do |stdin, stdout, stderr, wait_thr|
        assert_equal expected_stdout.chomp, stdout.read.chomp
        assert_equal 0, wait_thr.value
      end
    end
  end
end
