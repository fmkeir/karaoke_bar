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
    @guest4 = Guest.new("Amy", 18, 10, "Livin' on a prayer")
    @guest5 = Guest.new("Charles", 18, 4, "Save tonight")
    @group = [@guest1, @guest2, @guest3]

    @karaoke_bar = KaraokeBar.new("Singha's", [@room1, @room2], 100)
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
    @karaoke_bar.collect_entry_group([@guest3, @guest5])
    assert_equal([0, 4], [@guest3.wallet, @guest5.wallet])
    assert_equal(100, @karaoke_bar.till)
  end

  def test_determine_group_discount__none
    assert_equal(1, @karaoke_bar.determine_group_discount(@group))
  end

  def test_determine_group_discount__6_or_more
    large_group = [@guest1, @guest1, @guest1, @guest1, @guest1, @guest1]
    assert_equal(0.8, @karaoke_bar.determine_group_discount(large_group))
  end

  def test_collect_entry_fee_from_group__discount
    @guest3.wallet += 5
    @guest5.wallet += 5
    large_group = [@guest1, @guest2, @guest3, @guest4, @guest5]
    @karaoke_bar.collect_entry_group(large_group)
    assert_equal(122.5, @karaoke_bar.till)
  end

  def test_book_guest_into_room
    @karaoke_bar.book_guest_into_room(@guest1, @room1)
    assert_equal(105, @karaoke_bar.till)
    assert_equal([@guest1], @room1.view_current_guests)
  end

  def test_book_group_into_room
    @karaoke_bar.book_group_into_room([@guest1, @guest2, @guest4], @room2)
    assert_equal(115, @karaoke_bar.till)
    assert_equal([@guest1, @guest2, @guest4], @room2.view_current_guests)
  end

  def test_dont_allow_barred_guest
    @karaoke_bar.ban_guest(@guest1)
    @karaoke_bar.book_guest_into_room(@guest1, @room1)
    assert_equal([], @room1.view_current_guests)
  end
end
