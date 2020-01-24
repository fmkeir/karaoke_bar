require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
require_relative('../karaoke_bar')
require_relative('../song')
require_relative('../room')
require_relative('../guest')

class KaraokeBarTest < Minitest::Test
  def setup
    @song1 = Song.new("Bohemian Rhapsody")
    @song2 = Song.new("Don't stop believin")
    @song3 = Song.new("Born in the USA")
    @room1 = Room.new("A", [@song1], 10)
    @room2 = Room.new("B", [@song1, @song2, @song3], 5)

    @guest1 = Guest.new("Bill Billerson", 42, 100, "Bohemian Rhapsody")
    @guest2 = Guest.new("Toby", 17, 50, "Can't stop")
    @guest3 = Guest.new("Steph", 25, 0, "Tribute")
    @guest4 = Guest.new("Steph", 18, 4, "Tribute")
    @group = [@guest1, @guest2, @guest3]

    @karaoke_bar = KaraokeBar.new("Singha's", [@room1, @room2], 100, 5)
  end

  def test_get_name
    assert_equal("Singha's", @karaoke_bar.name)
  end

  def test_collect_entry_fee_from_guest__funds_available
    @karaoke_bar.collect_entry(@guest1)
    assert_equal(95, @guest1.wallet)
    assert_equal(105, @karaoke_bar.till)
  end

  def test_collect_entry_fee_from_guest__funds_unavailable
    @karaoke_bar.collect_entry(@guest3)
    assert_equal(0, @guest3.wallet)
    assert_equal(100, @karaoke_bar.till)
  end

  def test_collect_entry_fee_from_group__funds_available
    @karaoke_bar.collect_entry_group([@guest1, @guest2])
    assert_equal([95, 45], [@guest1.wallet, @guest2.wallet])
    assert_equal(110, @karaoke_bar.till)
  end

  def test_collect_entry_fee_from_group__funds_unavailable
    @karaoke_bar.collect_entry_group([@guest3, @guest4])
    assert_equal([0, 4], [@guest3.wallet, @guest4.wallet])
    assert_equal(100, @karaoke_bar.till)
  end
end
