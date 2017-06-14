class RestaurantsController < ApplicationController
  include WaittimeHelper
  include Waitcalc

  def waittime
    restaurant = Restaurant.find(params[:id])
    time = restaurant.most_recent_waittime
    if restaurant.is_open?
      base_alg_time = Restaurant.find(params[:id]).base_alg_time
      render html: "#{time.try(:estimated_waittime) || base_alg_time}"
    else
      render html: "Opens at #{restaurant.will_be_open}"
    end
  end

  def currentwaittime
    restaurant = Restaurant.find(params[:id])
    time = restaurant.current_estimated_wait
    render json: {time: time}.to_json
  end
end
