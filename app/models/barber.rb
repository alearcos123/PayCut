class Barber < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  include ValidateEmailUniquenessAcrossModels
  has_many :appointments
  has_many :customers, through: :appointments
  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password
  before_create :create_activation_digest
  def get_appointment
    @appointment = Appointment.new(@barber)
  end
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end
  def send_activation_email
   BarberMailer.account_activation(self).deliver_now
 end
  def remember
    self.remember_token = Barber.new_token
    update_attribute(:remember_digest, Barber.digest(remember_token))
  end
  def authenticated?(attribute, token)
   digest = send("#{attribute}_digest")
   return false if digest.nil?
   BCrypt::Password.new(digest).is_password?(token)
  end
  def forget
    update_attribute(:remember_digest, nil)
  end
  def Barber.new_token
    SecureRandom.urlsafe_base64
  end
  def Barber.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  private

  def create_activation_digest
      self.activation_token  = Barber.new_token
      self.activation_digest = Barber.digest(activation_token)
    end
end
