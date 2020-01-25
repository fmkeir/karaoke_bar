class KaraokeBar
  attr_reader :name, :till
  attr_accessor :entry_fee

  def initialize(name, rooms, till)
    @name = name
    @rooms = rooms
    @till = till
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
    if guest.wallet >= actual_entry_fee
      guest.wallet -= actual_entry_fee
      @till += actual_entry_fee
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
end
