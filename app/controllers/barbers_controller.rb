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

  # GET /barbers/1
  # GET /barbers/1.json
  def show

    if @barber.url == "" or @barber.url.nil?
      p "BARBER.URL IS EMPTY"
      gon.barberlatitude = 25.761681

      gon.barberlongitude = -80.191788
    else
      p "BARBER.URL IS PRESENT"
      example = (@barber.url).split("biz/")
      params[:business_id] = example.last

      business_id = params[:business_id]
      url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}"

      response = HTTP.auth("Bearer #{API_KEY}").get(url)

      #lookup has the complete response:
      lookup = response.parse

      @lookup = lookup
      #
      @barberkeys= lookup.keys
      #
      @barbername= lookup["name"]
      #  #
      @barberphone = lookup["display_phone"]
      #  #
      # @barberaddress= lookup["location"]["display_address"]
      @barberstreet = lookup["location"]["display_address"][0]
      @barbercitystatezip = lookup["location"]["display_address"][1]
      gon.barberlatitude = lookup["coordinates"]["latitude"]
      gon.barberlongitude = lookup["coordinates"]["longitude"]
    end
    if gon.clicked == true
      render '/day_schedules'
    end
  end

  # GET /barbers/new
  def new
    @barber = Barber.new
  end

  # GET /barbers/1/edit
  def edit

    # if gon.clicked == true
    #   p "============================================================"
    #   byebug
    #   if @barber.day_schedule(date_id: gon.day) == true
    #     render '/day_schedule/update'
    #   else
    #     render '/day_schedule/new'
    #   end
    # end

  end

  # POST /barbers
  # POST /barbers.json
  def create
    @barber = Barber.new(barber_params)
    @barber.url = params[:barber][:url]
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
