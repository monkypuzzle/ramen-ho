class RestaurantsController < ApplicationController
  include WaittimeHelper
  include Waitcalc

  def waittime
    restaurant = Restaurant.find(params[:id])
    time = restaurant.most_recent_waittime
    if restaurant.is_open?
      waittime = time.try(:estimated_waittime) || restaurant.base_alg_time
      render html: "<p class='waittime-num'> #{waittime}</p><p class='waittime-text'>minute</p><p class='waittime-text'>wait time!</p>".html_safe
    else
      render html: "Opens at #{restaurant.will_be_open}"
    end
  end
end
