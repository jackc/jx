require_relative "../../test_helper"

class TestAddition < IntegrationTest
  def test_addition
    stdout = run_jx File.join(__dir__, "addition.jx")
    assert_equal "John Smith42", stdout
  end
end
