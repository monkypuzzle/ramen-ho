class WaittimesController < ApplicationController

  def update
    waittime = Waittime.find(waittime_params[:id])
    waittime.update_attribute(:seated, true)
  end

  def create
    waittime = Waittime.create(party_size: params[:party_size], restaurant_id: 1)
    render json: waittime.to_json
  end

  def waittime_params
    params.require(:waittime).permit(:id)
  end
end
