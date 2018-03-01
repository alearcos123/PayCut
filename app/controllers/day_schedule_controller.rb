class DayScheduleController < ApplicationController
  #slot.slot_number is chosen by Barber when he decides which slots he wants not available
  def set_available(day_list, slot.slot_number, barber_id, date_id)
    n = 0
    for i in 0..(day_list.length - 1)
      if day_list[n].slot_number == slot.slot_number
        day_list[n].available = false
      else
        n+=1
      end
  end
end
