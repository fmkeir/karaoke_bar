class Room
  attr_reader :name, :capacity

  def initialize(room_name, playlist, capacity)
    @name = room_name
    @playlist = playlist
    @capacity = capacity
    @guests_in_room = []
  end

  def playlist_copy
    return @playlist[0..-1]
  end
end
