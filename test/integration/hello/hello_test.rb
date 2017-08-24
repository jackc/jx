require_relative "../../test_helper"

class TestHello < IntegrationTest
  def test_hello
    stdout = run_jx File.join(__dir__, "hello.jx")
    assert_equal stdout, "Hello, world!"
  end
end
