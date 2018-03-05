class Slot < ApplicationRecord
  belongs_to :services
  belongs_to :day_schedules
end
