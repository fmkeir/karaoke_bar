require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
require_relative('../guest')

class GuestTest < Minitest::Test
  def setup
    @guest = Guest.new("Bill Billerson", 42, 100, "Bohemian Rhapsody")
  end

  def test_get_name
    assert_equal("Bill Billerson", @guest.name)
  end
end
