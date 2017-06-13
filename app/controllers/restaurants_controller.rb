class RestaurantsController < ApplicationController
  include WaittimeHelper
  include Waitcalc

  def waittime
    time = Restaurant.find(params[:id]).most_recent_waittime
    base_alg_time = Restaurant.find(params[:id]).base_alg_time
    render html: "#{time.try(:estimated_waittime) || base_alg_time}"
  end
end
