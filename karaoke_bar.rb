class KaraokeBar
  attr_reader :name, :till

  def initialize(name, rooms, till, entry_fee)
    @name = name
    @rooms = rooms
    @till = till
    @entry_fee = entry_fee
  end

  def collect_entry(guest)
    if guest.wallet >= @entry_fee
      guest.wallet -= @entry_fee
      @till += @entry_fee
    end
  end

  def collect_entry_group(guest_array)
    guest_array.each {|guest| collect_entry(guest)}
  end
end
