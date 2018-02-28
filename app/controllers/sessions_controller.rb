class SessionsController < ApplicationController
    def new
    end

    def create
      barber = Barber.find_by(email: params[:session][:email].downcase)
      customer = Customer.find_by(email: params[:session][:email].downcase)
      if barber && barber.authenticate(params[:session][:password])
        p "authenticate"
        if barber.activated?
          log_in barber
          remember barber
          # params[:session][:remember_me] == '1' ? remember(barber) : forget(barber)
          redirect_to barber
          flash[:notice] = 'Welcome Back!'
        else
          message  = "Account not activated. "
          message += "Check your email for the activation link."
          flash[:notice] = message
          redirect_to root_url
        end
      elsif customer && customer.authenticate(params[:session][:password])
        if customer.activated?
          log_in customer
          remember customer
          # params[:session][:remember_me] == '1' ? remember(customer) : forget(customer)
          redirect_to customer
          flash[:notice] = 'Welcome Back!'
        else
          message  = "Account not activated. "
          message += "Check your email for the activation link."
          flash[:notice] = message
          redirect_to root_url
        end
      else
        flash[:notice] = 'Invalid email/password combination'
        render 'new'
      end
    end

    def destroy
      log_out if logged_in?
      redirect_to login_path
    end
  end
