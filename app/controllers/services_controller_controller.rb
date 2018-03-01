class ServicesControllerController < ApplicationController
  #start_slot is the time slot the customer chooses to start their appointment at
  def sort_slots(start_slot, service_id, date_id, barber_id)
    n = start_slot.slot_number
    for i in 0..(service_id.service_list.length - 1)
      if Dayschedule.day_list[n].available == false
        return false
      else
        n+= 1
      end
    end
    return true
  end
end
