class Slot < ApplicationRecord
  belongs_to :service
  belongs_to :day_schedule
end
