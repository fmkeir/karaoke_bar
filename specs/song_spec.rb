require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
require_relative('../song')

class SongTest < Minitest::Test
  def test_get_name
    song = Song.new("Bohemian Rhapsody")
    assert_equal("Bohemian Rhapsody", song.name)
  end
end
