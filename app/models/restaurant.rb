require 'waitcalc'

class Restaurant < ActiveRecord::Base
  has_many :waittimes
  has_one :admin

  def standard_time(string)
    p string
    time = string.gsub(/[:]/, "")
    if time.include?("12")
      result = time.gsub(/^\d{2}/, '12:')
      result = result + "PM"
    elsif time > ("1200")
      first_two = time.match(/^\D*(\d)\D*(\d)/).captures.join
      new_hour = first_two.to_i - 12
      result = time.gsub(/^\d{2}/, new_hour.to_s + ':')
      if first_two == "24"
        result = result + "AM"
      else
        result = result + "PM"
      end
    else
      p time
      p time.match(/^\D*(\d)\D*(\d)/)
      first_two = time.match(/^\D*(\d)\D*(\d)/).captures.join
      result = time.gsub(/^\d{2}/, first_two + ':')
      result = result + " AM"
    end

    result
  end

  def most_recent_waittime
    waittimes.order(created_at: :desc).find_by(seated: false)
  end

  def base_alg_time
    Waitcalc.base_alg(self.number_of_seats)[:alg_time]
  end

  def base_avg_time
    Waitcalc.base_alg(self.number_of_seats)[:avg_time]/2
  end
  def is_open?
    current_mil_time =Time.now.strftime('%H:%M')
    # current_mil_time =Time.new(2017,6,13,2,25,0, "-08:00").strftime('%H:%M')
    current_day = Time.now.strftime("%A").downcase
    # current_day = Time.new(2017,6,13,2,25,0, "-08:00").strftime("%A").downcase
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
    # current_mil_time =Time.new(2017,6,13,2,25,0, "-08:00").strftime('%H:%M')
    current_day = Time.now.strftime("%A").downcase
    # current_day = Time.new(2017,6,13,2,25,0, "-08:00").strftime("%A").downcase
    if self.is_open? == false
      if current_mil_time < self.operating_hours[current_day]["lunch"][0]
        standard_time(self.operating_hours[current_day]["lunch"][0]) + " later today"
      elsif current_mil_time.between?(self.operating_hours[current_day]["lunch"][1],self.operating_hours[current_day]["dinner"][0])
        standard_time(self.operating_hours[current_day]["dinner"][0]) + " this evening"
      elsif current_mil_time > self.operating_hours[current_day]["dinner"][1]
        tomorrow = (Date.today + 1).strftime("%A").downcase
        day_after_tmrw = (Date.today + 2).strftime("%A").downcase
        day_future = (Date.today + 3).strftime("%A").downcase
          if self.operating_hours[tomorrow]["lunch"][0] != "0"
             standard_time(self.operating_hours[tomorrow]["lunch"][0]) + " on " + tomorrow.capitalize
          elsif self.operating_hours[tomorrow]["lunch"][0] == "0"
             standard_time(self.operating_hours[tomorrow]["dinner"][0]) + " on " + tomorrow.capitalize
          elsif self.operating_hours[tomorrow]["lunch"][0] == "0" && self.operating_hours[tomorrow]["dinner"][0] == "0"
             standard_time(self.operating_hours[day_after_tmrw]["lunch"][0]) + " on " + day_after_tmrw.capitalize
          elsif self.operating_hours[tomorrow]["lunch"][0] == "0" && self.operating_hours[tomorrow]["dinner"][0] == "0" && self.operating_hours[day_after_tmrw]["lunch"][0] == "0" + "on " + day_after_tmrw.capitalize
             standard_time(self.operating_hours[day_after_tmrw]["dinner"][0])
          elsif self.operating_hours[tomorrow]["lunch"][0] == "0" && self.operating_hours[tomorrow]["dinner"][0] == "0" && self.operating_hours[day_after_tmrw]["lunch"][0] == "0" && self.operating_hours[day_after_tmrw]["dinner"][0] == "0"
             standard_time(self.operating_hours[day_future]["lunch"][0]) + " on " + day_future.capitalize
          end
      end
    elsif self.is_open?
      if current_mil_time.between?(self.operating_hours[current_day]["dinner"][0],self.operating_hours[current_day]["dinner"][1])
        standard_time(self.operating_hours[current_day]["dinner"][0])
      elsif current_mil_time.between?(self.operating_hours[current_day]["lunch"][0],self.operating_hours[current_day]["lunch"][1])
        standard_time(self.operating_hours[current_day]["lunch"][0])
      end
    else
      "w0t"
    end
  end

  def current_estimated_wait
    base_avg_time + most_recent_waittime.estimated_waittime
  end

end
