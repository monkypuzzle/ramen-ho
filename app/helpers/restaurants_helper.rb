module RestaurantsHelper

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

  def day_format(string)
    result = string.match(/^\w{3}/)
    result
  end

  def hours_parse(hours_in_json)
    arr = hours_in_json.map{|day| day}
    days = []
    lunch_hours = []
    dinner_hours =[]
    i = 0
    until i == arr.length
      days << arr[i][0]
      lunch_hours << arr[i][1]["lunch"]
      dinner_hours << arr[i][1]["dinner"]
      i += 1
    end

  lunch_hours.flatten
  dinner_hours.flatten
  info_hash = {day_list: days, lunch: lunch_hours, dinner: dinner_hours}
  end



  def hours_show(hours)
    hash = hours_parse(hours)
    display = []
    display_day = []
    # puts hash
    i = 0
    until i == hash[:day_list].length
      if hash[:lunch][i][0] == "0" && hash[:dinner][i][0] == "0"
        display_day << day_format(hash[:day_list][i].capitalize)
        display << ":  - CLOSED - "
      elsif hash[:lunch][i][1] == "0" && hash[:dinner][i][0] == "0"
        display_day << day_format(hash[:day_list][i].capitalize)
        display << ":  " + standard_time(hash[:lunch][i][0]) + " -  " + standard_time(hash[:dinner][i][1])
      else
        display_day << day_format(hash[:day_list][i].capitalize)
        display << ": " + standard_time(hash[:lunch][i][0]) + " - " + standard_time(hash[:lunch][i][1]) + " || " +  standard_time(hash[:dinner][i][0]) + " - " + standard_time(hash[:dinner][i][1])
      end
      i += 1
    end

    display_day.insert(0, display_day.delete_at(2))
    display_day.insert(1, display_day.delete_at(2))
    display_day.insert(2, display_day.delete_at(3))
    display_day.insert(3, display_day.delete_at(6))
    display_day.insert(4, display_day.delete_at(6))

    display.insert(0, display.delete_at(2))
    display.insert(1, display.delete_at(2))
    display.insert(2, display.delete_at(3))
    display.insert(3, display.delete_at(6))
    display.insert(4, display.delete_at(6))

    {days: display_day, hours: display}
  end

end
