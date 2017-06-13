class Restaurant < ActiveRecord::Base
  has_many :waittimes
  has_one :admin

  def is_open?
    current_mil_time =Time.now.strftime('%H:%M')
    current_day = Time.now.strftime("%A").downcase
    if current_mil_time < self.operating_hours[current_day]["lunch"][0]
      false
    elsif current_mil_time.between?(self.operating_hours[current_day]["lunch"][1],self.operating_hours[current_day]["dinner"][0])
      false
    elsif current_mil_time > self.operating_hours[current_day]["dinner"][1]
      false
    else
      true
    end
  end

  def will_be_open
    current_mil_time =Time.now.strftime('%H:%M')
    # current_mil_time =Time.new(2017,6,11,12,25,0, "-7:00").strftime('%H:%M')
    current_day = Time.now.strftime("%A").downcase
    if self.is_open? == false
      if current_mil_time < self.operating_hours[current_day]["lunch"][0]
        self.operating_hours[current_day]["lunch"][0]
      elsif current_mil_time.between?(self.operating_hours[current_day]["lunch"][1],self.operating_hours[current_day]["dinner"][0])
        self.operating_hours[current_day]["dinner"][0]
      elsif current_mil_time > self.operating_hours[current_day]["dinner"][1]
        tomorrow = (Date.today + 1).strftime("%A").downcase
        day_after_tmrw = (Date.today + 2).strftime("%A").downcase
        day_future = (Date.today + 3).strftime("%A").downcase
          if self.operating_hours[tomorrow]["lunch"][0] != "0"
             self.operating_hours[tomorrow]["lunch"][0]
          elsif self.operating_hours[tomorrow]["lunch"][0] == "0"
             self.operating_hours[tomorrow]["dinner"][0]
          elsif self.operating_hours[tomorrow]["lunch"][0] == "0" && self.operating_hours[tomorrow]["dinner"][0] == "0"
             self.operating_hours[day_after_tmrw]["lunch"][0]
          elsif self.operating_hours[tomorrow]["lunch"][0] == "0" && self.operating_hours[tomorrow]["dinner"][0] == "0" &&          self.operating_hours[day_after_tmrw]["lunch"][0] == "0"
             self.operating_hours[day_after_tmrw]["dinner"][0]
          elsif self.operating_hours[tomorrow]["lunch"][0] == "0" && self.operating_hours[tomorrow]["dinner"][0] == "0" && self.operating_hours[day_after_tmrw]["lunch"][0] == "0" && self.operating_hours[day_after_tmrw]["dinner"][0] == "0"
             self.operating_hours[day_future]["lunch"][0]
          end
      end
    elsif self.is_open?
      if current_mil_time.between?(self.operating_hours[current_day]["dinner"][0],self.operating_hours[current_day]["dinner"][1])
        self.operating_hours[current_day]["dinner"][0]
      elsif current_mil_time.between?(self.operating_hours[current_day]["lunch"][0],self.operating_hours[current_day]["lunch"][1])
        self.operating_hours[current_day]["lunch"][0]
      end
    else
      "w0t"
    end
  end

end
