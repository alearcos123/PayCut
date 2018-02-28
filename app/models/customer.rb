class Customer < ApplicationRecord
  attr_accessor :reset_token, :remember_token, :activation_token
  include ValidateEmailUniquenessAcrossModels
  has_many :appointments
  has_many :barbers, through: :appointments
  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true
  has_secure_password
  before_create :create_activation_digest
  def remember
    self.remember_token = Customer.new_token
    update_attribute(:remember_digest, Customer.digest(remember_token))
  end
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end
  def send_activation_email
   CustomerMailer.account_activation(self).deliver_now
 end
  def authenticated?(attribute, token)
   digest = send("#{attribute}_digest")
   return false if digest.nil?
   BCrypt::Password.new(digest).is_password?(token)
  end
  def forget
    update_attribute(:remember_digest, nil)
  end
  def Customer.new_token
    SecureRandom.urlsafe_base64
  end
  def Customer.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  def create_reset_digest
    self.reset_token = Customer.new_token
    update_attribute(:reset_digest,  Customer.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  def send_password_reset_email
    CustomerMailer.password_reset(self).deliver_now
  end
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private
    def create_activation_digest
      self.activation_token  = Customer.new_token
      self.activation_digest = Customer.digest(activation_token)
    end
end
