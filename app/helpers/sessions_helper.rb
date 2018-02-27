module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id

  end
  def current_user
    @current_user ||= Customer.find_by(session[:customer_id]) or Barber.find_by(session[:barber_id])
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
