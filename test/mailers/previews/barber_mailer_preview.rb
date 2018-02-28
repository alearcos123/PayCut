# Preview all emails at http://localhost:3000/rails/mailers/barber_mailer
class BarberMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/barber_mailer/account_activation
  def account_activation
    BarberMailer.account_activation
  end

  # Preview this email at http://localhost:3000/rails/mailers/barber_mailer/password_reset
  def password_reset
    BarberMailer.password_reset
  end

end
