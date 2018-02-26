class Appointment < ApplicationRecord
  belongs_to :customers
  belongs_to :barbers
end
