class DaySchedule < ApplicationRecord
  has_many :slots
  belongs_to :barber

  def day_list(time_slots, date_id, barber_id)
    day_schedule = DaySchedule.find_by(barber_id: barber_id, date_id: date_id)
    barber_id = barber_id.to_i
    n = 0
    day_array = []

    for i in 0..(time_slots - 1)

      slot = Slot.new(barber_id: barber_id, date_id: date_id, day_schedule_id: day_schedule.id)
      slot.slot_number = n
      slot.save
      day_array << slot
      n+= 1
    end
    return day_array
  end
end
