class Barber < ApplicationRecord
  has_many :appointments
  has_many :customers, through: :appointments
  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password
  def get_appointment
    @appointment = Appointment.new(@barber)
  end
end
