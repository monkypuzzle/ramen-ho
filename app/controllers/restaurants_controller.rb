class RestaurantsController < ApplicationController
  include WaittimeHelper
  include Waitcalc

  def waittime
    restaurant = Restaurant.find(params[:id])
    waittime = restaurant.current_waittime
    if restaurant.is_open?
      render html: "<p class='waittime-num'> #{waittime}</p><p class='waittime-text'>minute</p><p class='waittime-text'>wait time!</p>".html_safe
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
