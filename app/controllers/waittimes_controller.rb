class WaittimesController < ApplicationController

  def update
    seated_waittime = Waittime.where(seated: false).order(:created_at)
    seated_waittime.update(:seated, true)
  end

  def create
    waittime = Waittime.create(party_size: params[:party_size], restaurant_id: 1)

    render json: waittime.to_json
  end
end
