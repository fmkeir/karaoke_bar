class KaraokeBar
  attr_reader :name
  
  def initialize(name, rooms, till, entry_fee)
    @name = name
    @rooms = rooms
    @till = till
    @entry_fee = entry_fee
  end
end
