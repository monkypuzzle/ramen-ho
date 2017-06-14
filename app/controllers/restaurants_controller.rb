class RestaurantsController < ApplicationController
  include WaittimeHelper
  include Waitcalc

  def waittime
    restaurant = Restaurant.find(params[:id])
    time = restaurant.most_recent_waittime
    if restaurant.is_open?
      base_alg_time = Restaurant.find(params[:id]).base_alg_time
      render html: "Wait Time - #{time.try(:estimated_waittime) || base_alg_time} minutes"
    else
      render html: "Open at: #{restaurant.will_be_open}"
    end
  end
end
