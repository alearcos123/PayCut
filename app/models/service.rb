class Service < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :barber
  #service_id has access to the time_slots it has

end
