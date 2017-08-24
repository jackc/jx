require_relative "../../test_helper"

class TestWhile < IntegrationTest
  def test_while
    stdout = run_jx File.join(__dir__, "while.jx")
    assert_equal "HelloHelloHello", stdout
  end
end
