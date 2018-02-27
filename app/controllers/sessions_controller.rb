class SessionsController < ApplicationController
    def new
    end

    def create
      barber = Barber.find_by(email: params[:session][:email].downcase)
      customer = Customer.find_by(email: params[:session][:email].downcase)
    
      if barber && barber.authenticate(params[:session][:password])
        log_in barber
        redirect_to root_path
        flash[:notice] = 'Welcome Back!'
      elsif customer && customer.authenticate(params[:session][:password])
        log_in customer
        redirect_to root_path
        flash[:notice] = 'Welcome Back!'
      else
        flash[:notice] = 'Invalid email/password combination'
        render 'new'
      end
    end

    def destroy
      log_out
      redirect_to login_path
    end
  end
