module WaittimeHelper

  def number_of_unseated_parties(restaurant)
    Waittime.where(restaurant_id: restaurant.id, seated: false).count
  end

  def find_waittime_id(waittime_string)
    waittime_string[/\d+/]
  end

  def fake_wait(restaurantId)
    Waittime.where(restaurant_id: 1, seated: false).count
  end
end
