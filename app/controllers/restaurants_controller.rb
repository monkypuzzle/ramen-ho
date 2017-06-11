class RestaurantsController < ApplicationController
  include WaittimeHelper

  def waittime
    time = fake_wait(params[:id])
    render html: "#{time}"
  end
end
