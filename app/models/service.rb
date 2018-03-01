class Service < ApplicationRecord
  #service_id has access to the time_slots it has
  def service_list(barber_id, service_id)
    for i in 0..(service.time_slots - 1)
      slot = Slot.new(barber_id, service_id)
      service_array = []
      service_array << slot
    end
    return service_array
  end
end
