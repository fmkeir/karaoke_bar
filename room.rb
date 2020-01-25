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

  def view_current_guests
    return @guests_in_room[0..-1]
  end

  def add_song(song)
    @playlist.push(song)
  end

  def add_guest(guest)
    @guests_in_room.push(guest) if enough_space?()
  end

  def add_group(guest_array)
      if enough_space_for_group?(guest_array)
        guest_array.each {|guest| add_guest(guest)}
      end
  end

  def remove_guest(guest)
    @guests_in_room.delete(guest)
  end

  def remove_group(guest_array)
    guest_array.each {|guest| remove_guest(guest)}
  end

  def enough_space?
    return @guests_in_room.length < @capacity
  end

  def enough_space_for_group?(guest_array)
    return (@guests_in_room.length + guest_array.length) < @capacity
  end
end
