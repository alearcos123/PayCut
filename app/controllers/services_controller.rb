class ServicesController < ApplicationController
  #start_slot is the time slot the customer chooses to start their appointment at
  # def sort_slots(, service_id, date_id, barber_id)
  #   n = start_slot.slot_number
  #   start_slot is the index of the slot in the daylist
  #   for i in 0..(service_id.service_list.length - 1)
  #     if Dayschedule.slots[n].available == false
  #       return false
  #     else
  #       n+= 1
  #     end
  #   end
  #   return true
  # end
  def get_service
    @current_service = (params[:service]).to_i
    p "==================================="
    p @current_service
    @date_id = params[:date_id]
    @slot_number = params[:slot_number]
    @barber_id = params[:barber_id]
    if @barber_id and @slot_number and @date_id and @current_service
      p "================================"
      p "ajax worked"
      day_list = DaySchedule.find_by(barber_id: @barber_id, date_id: @date_id).slots
      n = @slot_number
        for i in 0..(@current_service)
          if day_list[n].available == false
            return false
          else
            n+= 1
          end
        end
        return true
    end
  end
  def new
    times = [30, 60, 90, 120, 150, 180]
    @duration = times.map do |time|
      "#{time} minutes"
    end


    @service = Service.new
  end
  def create
    time = params[:duration].gsub(/[minutes]/, '').to_i
    time_slots = time/30

    @service = Service.new(barber_id: params[:barber_id], price: params[:service][:price], description: params[:service][:description], time_slots: time_slots)
    @service.save
    redirect_to "/barbers/#{params[:barber_id]}/edit"
  end
  def edit
  end
end
