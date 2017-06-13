module RestaurantsHelper

  def hours_parse(hours_in_json)
    arr = hours_in_json.map{|day| day}
    days = []
    lunch_hours = []
    dinner_hours =[]
    i = 0
    until i == arr.length - 1
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
    i = 0
    until i == hash[:day_list].length - 1
      if hash[:lunch][i][1] == "0" && hash[:dinner][i][0]
        display << hash[:day_list][i].capitalize  + ":  Open From: " +  hash[:lunch][i][0] + " -  " + hash[:dinner][i][1]
      else
        display << hash[:day_list][i].capitalize  + ":  Lunch: " +  hash[:lunch][i][0] + " - " + hash[:lunch][i][1] + " || Dinner: " +  hash[:dinner][i][0] + " - " + hash[:dinner][i][1]
      end
      i += 1
    end

    display
  end


end
