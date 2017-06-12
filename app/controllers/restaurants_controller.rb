class RestaurantsController < ApplicationController
  include WaittimeHelper
  include Waitcalc

  def waittime
    time = Restaurant.find(params[:id]).most_recent_waittime
    render html: "#{time.try(:estimated_waittime) || 0}"
  end
end
