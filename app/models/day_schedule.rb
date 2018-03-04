class DaySchedule < ApplicationRecord
  has_many :slots
  belongs_to :barbers
  def day_list(time_slots, date_id, barber_id)
    n = 0
    for i in 0..(time_slots - 1)
      slot = Slot.new(barber_id, date_id)
      slot.slot_number = n
      day_array = []
      day_array << slot
      n+= 1
    end
    return day_array
  end
end
