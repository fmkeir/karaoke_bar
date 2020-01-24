require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
require_relative('../room')
require_relative('../song')
require_relative('../guest')

class RoomTest < Minitest::Test
  def setup
    @song1 = Song.new("Bohemian Rhapsody")
    @song2 = Song.new("Don't stop believin")
    @song3 = Song.new("Born in the USA")
    @playlist = [@song1, @song2, @song3]

    @guest1 = Guest.new("Bill Billerson", 42, 100, "Bohemian Rhapsody")
    @guest2 = Guest.new("Toby", 17, 50, "Can't stop")
    @guest3 = Guest.new("Steph", 25, 0, "Tribute")
    @group = [@guest1, @guest2, @guest3]

    @room = Room.new("Classics", @playlist, 10)
  end

  def test_get_room_name
    assert_equal("Classics", @room.name)
  end

  def test_get_copy_room_playlist
    assert_equal(@playlist, @room.playlist_copy)
  end

  def test_get_copy_room_playlist__cant_edit
    @room.playlist_copy << Song.new("Horse with no name")
    assert_equal(@playlist, @room.playlist_copy)
  end

  def test_get_room_capacity
    assert_equal(10, @room.capacity)
  end

  def test_get_current_guests__none
    assert_equal([], @room.view_current_guests)
  end
end
