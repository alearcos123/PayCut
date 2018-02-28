class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  def new
  end

  def create
    @user = Customer.find_by(email: params[:password_reset][:email].downcase) or Barber.find_by(email: params[:password_reset][:email].downcase)
    p @user
    if @user && @user != nil
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:notice] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash[:notice] = "Email address not found"
      render 'new'
      p "else is triggered"
    end
  end

  def edit
  end
  def update
    if params[:customer] !=nil
      if params[:customer][:password].empty?            # Case (3)
        @user.errors.add(:password, "can't be empty")
        render 'edit'
      elsif @user.update_attributes(user_params)          # Case (4)
        log_in @user
        flash[:notice] = "Password has been reset."
        redirect_to @user
      end
    elsif params[:barber] !=nil
      if params[:barber][:password].empty?
        @user.errors.add(:password, "can't be empty")
        render 'edit'
      elsif @user.update_attributes(user_params)          # Case (4)
        log_in @user
        flash[:notice] = "Password has been reset."
        redirect_to @user
      end
    else
      render 'edit'                                     # Case (2)
    end
  end
  private
    def user_params
      if params[:customer] !=nil
        params.require(:customer).permit(:password, :password_confirmation)
      elsif params[:customer] !=nil
        params.require(:barber).permit(:password, :password_confirmation)
      end
    end
   def get_user
     @user = Customer.find_by(email: params[:email]) or Barber.find_by(email: params[:email])
   end

   # Confirms a valid user.
   def valid_user
     unless (@user && @user.activated? &&
             @user.authenticated?(:reset, params[:id]))
       redirect_to root_url
     end
   end
   def check_expiration
     if @user.password_reset_expired?
       flash[:danger] = "Password reset has expired."
       redirect_to new_password_reset_url
     end
   end
end
