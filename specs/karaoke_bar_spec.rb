require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
require_relative('../karaoke_bar')

class KaraokeBarTest < Minitest::Test
  def setup
    @karaoke_bar = KaraokeBar.new("Singha's", @rooms, 100, 5)
  end

  def test_get_name
    assert_equal("Singha's", @karaoke_bar.name)
  end
end
