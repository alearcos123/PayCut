class Customer < ApplicationRecord
  has_many :appointments
  has_many :barbers, through: :appointments
  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password
end
