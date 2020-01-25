class KaraokeBar
  attr_reader :name, :till
  attr_accessor :entry_fee

  def initialize(name, rooms, till)
    @name = name
    @rooms = rooms
    @till = till
    @banned_guests = []
    @entry_fee = 5
    # Group discounts as a percentage of entry fee for a group of key or more
    @group_discounts = {
      5 => 0.9,
      6 => 0.8,
      10 => 0.6
    }
  end

  def collect_entry(guest, group_discount=1)
    actual_entry_fee = @entry_fee * group_discount
    if guest.wallet >= actual_entry_fee && not_banned?(guest)
      guest.wallet -= actual_entry_fee
      @till += actual_entry_fee
      return true
    end
  end

  def collect_entry_group(guest_array)
    group_discount = determine_group_discount(guest_array)
    guest_array.each {|guest| collect_entry(guest, group_discount)}
  end

  def determine_group_discount(guest_array)
    group_size = guest_array.length
    discount_multiplier = 1
    for min_group_size in @group_discounts.keys.sort
      if group_size >= min_group_size
        discount_multiplier = @group_discounts[min_group_size]
      end
    end
    return discount_multiplier
  end

  def book_guest_into_room(guest, room)
    room.add_guest(guest) if collect_entry(guest)
  end

  def book_group_into_room(group, room)
    room.add_group(group) if collect_entry_group(group)
  end

  def ban_guest(guest)
    @banned_guests.push(guest)
  end

  def not_banned?(guest)
    return !@banned_guests.include?(guest)
  end
end
