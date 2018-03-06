class DayScheduleController < ApplicationController
  def update
    #slot.slot_number is chosen by Barber when he decides which slots he wants not available
    # def set_available(slot.slot_number, barber_id, date_id)
    #   n = 0
    #   for i in 0..(day_list.length - 1)
    #     if day_list[n].slot_number == slot.slot_number
    #       day_list[n].available = false
    #     else
    #       n+=1
    #     end
    # end
    @date = params[:date_id]
    @barber = params[:barber_id]
  end
  def new
    @day_schedule = DaySchedule.new

    # in a controller
    @open_times = ((5..12).to_a + (1..4).to_a).map {|time|
      result = "#{time}:00 "
      if time > 4 && time < 12
        result << "am"
      else
        result << "pm"
      end
      result
    }


    # in a controller
    @close_times = ((11..12).to_a + (1..10).to_a).map {|time|
      result = "#{time}:00 "
      if time == 11
        result << "am"
      else
        result << "pm"
      end
      result
    }

    @date = params[:date]
    @barber = params[:barber_id]


  end

  def create
    @open_times = ((5..12).to_a + (1..4).to_a).map {|time|
      result = "#{time}:00 "
      if time > 4 && time < 12
        result << "am"
      else
        result << "pm"
      end
      result
    }


    # in a controller
    @close_times = ((11..12).to_a + (1..10).to_a).map {|time|
      result = "#{time}:00 "
      if time == 11
        result << "am"
      else
        result << "pm"
      end
      result
    }
    if !params[:closing_hour].blank? and !params[:opening_hour].blank?

      oh = params[:opening_hour]
      if (oh.include?('pm') and !oh.include?('12'))
        first_time = (oh.gsub(/[:00pm]/, '')).to_i + 12
      elsif (oh.include?('12'))
        first_time = (oh.gsub(/[:00pm]/, '')).to_i
      else
        first_time = (oh.gsub(/[:00am]/, '')).to_i
      end

      ch = params[:closing_hour]
      if (ch.include?('pm') and !oh.include?('12'))
        second_time = (ch.gsub(/[:00pm]/, '')).to_i + 12
      elsif (ch.include?('12'))
        second_time = (ch.gsub(/[:00pm]/, '')).to_i
      else
        second_time = (ch.gsub(/[:00am]/, '')).to_i
      end
      time_slots = 2* (second_time - first_time)
      # @day_schedule(time_slots: time_slots)




      @day_schedule = DaySchedule.new(barber_id: params[:barber_id].to_i, time_slots: time_slots, date_id: params[:day])
      @day_schedule.save
      redirect_to root_url
    elsif (params[:opening_hour] == "")
      p "oh is nil"
      flash[:notice] = "Please Select an Opening Time"
      redirect_back(fallback_location: root_path)
    else
      p "ch is nil"
      flash[:notice] = "Please Select a Closing Time"
      redirect_back(fallback_location: root_path)
    end
  end
  def show
  end

end
