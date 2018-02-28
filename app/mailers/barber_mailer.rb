class BarberMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.barber_mailer.account_activation.subject
  #
  def account_activation(barber)
    @barber = barber

    mail to: barber.email, subject: "Account Activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.barber_mailer.password_reset.subject
  #
  def password_reset(barber)
    @barber = barber

    mail to: barber.email, subject: "Password Reset"
  end
end
