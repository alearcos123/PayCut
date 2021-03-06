class BarbersController < ApplicationController
require 'http'
require 'nokogiri'
require "json"
require "httparty"


  before_action :set_barber, only: [:show, :edit, :update, :destroy]

  # GET /barbers
  # GET /barbers.json

  def search
    @barbers = if params[:name]
    Barber.where('name LIKE ?', "%#{params[:name]}%")
  else
    @barbers = nil
  end
  end

  def index
    # gon.test = "test"
    @barbers = Barber.all

  end

  def stripe_callback
            options = {
              site: 'https://connect.stripe.com',
              authorize_url: '/oauth/authorize',
              token_url: '/oauth/token'
            }
            code = params[:code]
            client = OAuth2::Client.new(ENV['STRIPE_CONNECT_CLIENT_ID'], ENV['SECRET_KEY'], options)
            @resp = client.auth_code.get_token(code, :params => {:scope => 'read_write'})
            @access_token = @resp.token
            @barber.update!(uid: @resp.params["stripe_user_id"]) if @resp
            flash[:notice] = "Your account has been successfully created and is ready to process payments!"
  end

   # //this is where a user will be able to see their balance info
  def payment_profile
      @account = Stripe::Account.retrieve("#{@barber.uid.to_s}") if @barber.uid.present?
      @balance = Stripe::Balance.retrieve() if @barber.uid.present?
  end

  # GET /barbers/1
  # GET /barbers/1.json
  def show
    @date = gon.day

    if @barber.url == "" or @barber.url.nil?
      p "BARBER.URL IS EMPTY"
      gon.barberlatitude = 25.761681

      gon.barberlongitude = -80.191788
    else
      p "BARBER.URL IS PRESENT"

      example = (@barber.url).split("biz/")

      business_id = example.last
      url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}"

      response = HTTP.auth("Bearer #{API_KEY}").get(url)

      #lookup has the complete response:
      lookup = response.parse

      @barber.barberName= lookup["name"]
      #
      @barber.phone = lookup["display_phone"]
      #
      @barber.address= lookup["location"]["display_address"]
      @barberstreet = lookup["location"]["display_address"][0]
      @barbercitystatezip = lookup["location"]["display_address"][1]
      #
      @barber.rating = lookup["rating"]
      #
      @barber.photoUrl = lookup["photos"]
      @barberphotos = lookup["photos"]
      gon.barberlatitude = lookup["coordinates"]["latitude"]
      gon.barberlongitude = lookup["coordinates"]["longitude"]
    end


  end


  # GET /barbers/new
  def new
    @barber = Barber.new

  end

  # GET /barbers/1/edit
  def edit


    @service = Service.new
    times = [30, 60, 90, 120, 150, 180]
    @duration = times.map do |time|
      "#{time} minutes"
    end
    @barber_id = params[:id]


  end

  # POST /barbers
  # POST /barbers.json
  def create
    @barber = Barber.new(barber_params)
    @barber.url = params[:barber][:url]    #save in the table the params introduced
    @barber.barberName = params[:barber][:barberName]
    @barber.phone = params[:barber][:phone]
    @barber.address = params[:barber][:address]
    @barber.photoUrl = params[:barber][:photoUrl]





    if @barber.url == "" or @barber.url.nil?
      p "BARBER.URL IS EMPTY"
      gon.barberlatitude = 25.761681
      gon.barberlongitude = -80.191788
    else
      example = (@barber.url).split("biz/")

      business_id = example.last
      url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}"

      response = HTTP.auth("Bearer #{API_KEY}").get(url)

      #lookup has the complete response:
      lookup = response.parse

      @barber.barberName= lookup["name"]
      #
      @barber.phone = lookup["display_phone"]
      #
      @barber.address= "#{lookup["location"]["display_address"][0]}, #{lookup["location"]["display_address"][1]}"

      @barber.rating = lookup["rating"]

      @barber.photoUrl = lookup["photos"][0]
    end



      if @barber.save
        # gon.clicked = false
        @barber.send_activation_email
        logout(@barber)
        redirect_to root_url
        flash[:info] = "Please check your email to activate your account."
      else
        render :new
      end
  end

  # PATCH/PUT /barbers/1
  # PATCH/PUT /barbers/1.json
  def update
    respond_to do |format|
      if @barber.update(barber_params)
        format.html { redirect_to @barber, notice: 'Barber was successfully updated.' }
        format.json { render :show, status: :ok, location: @barber }
      else
        format.html { render :edit }
        format.json { render json: @barber.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /barbers/1
  # DELETE /barbers/1.json
  def destroy
    @barber.destroy
    respond_to do |format|
      format.html { redirect_to barbers_url, notice: 'Barber was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def analytics
  end

  private
    def logout(user)
      session.delete(:user_id)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_barber
      @barber = Barber.find(params[:id])

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def barber_params
      params.require(:barber).permit(:name, :email, :password, :password_confirmation)
    end
end
