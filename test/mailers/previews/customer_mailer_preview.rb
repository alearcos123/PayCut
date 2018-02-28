# Preview all emails at http://localhost:3000/rails/mailers/customer_mailer
class CustomerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/customer_mailer/account_activation
  def account_activation
    CustomerMailer.account_activation
  end

  # Preview this email at http://localhost:3000/rails/mailers/customer_mailer/password_reset
  def password_reset
    CustomerMailer.password_reset
  end

end
