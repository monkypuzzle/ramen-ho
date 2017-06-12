module WaittimeHelper

  def number_of_unseated_parties(restaurant)
    Waittime.where(restaurant_id: restaurant.id, seated: false).count
  end

  def find_waittime_id(waittime_string)
    waittime_string[/\d+/]
  end

  def get_waittime(restaurant_id)
    puts restaurant_id
    Waittime.most_recent_waittime(restaurant_id).estimated_waittime
  end
end
