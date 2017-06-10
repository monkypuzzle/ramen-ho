module WaittimeHelper

  def number_of_unseated_parties(restaurant)
    Waittime.where(restaurant_id: restaurant.id, seated: false).count
  end

end
