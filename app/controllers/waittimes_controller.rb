class WaittimesController < ApplicationController
  include SmsHelper
  include WaittimeHelper

  def update
    waittime = Waittime.find(waittime_params[:id])
    unseated_waittimes = Waittime.where(restaurant_id: waittime.restaurant.id).where(seated: false)
    estimated_waittimes = {}
    unseated_waittimes.each do |waittime|
      estimated_waittimes[waittime.id] = waittime.estimated_waittime
    end
    waittime.update(seated: true)
    render json: estimated_waittimes.to_json
  end

  def create
    @waittime = Waittime.new(waittime_params)
    # Added 'restaurant' = takes advantage of restaurant hasone admin association
    @waittime.restaurant = current_admin.restaurant
    #use waittime helper method to add number of parties before saving
    @waittime.number_of_parties_before = number_of_unseated_parties(current_admin.restaurant)
    if @waittime.save
      # send_confirmation_sms(@waittime.phone)
      render partial: 'waittimes/create_w_db', locals: {waittime: @waittime}, layout: false
    else
      #errors aren't working, implemented grayed out function instead - will revisit on Monday
      render partial: "/waittime/errors.html.erb", locals: { waittime: @waittime}, layout: false
    end
  end

  def send_notice
    waittime_id = find_waittime_id(params[:id])
    waittime = Waittime.find(waittime_id)
    # send_ready_sms(waittime.phone)
    render plain: params[:id]
  end

  def waittime_params
    params.require(:waittime).permit(:id, :customer, :phone, :party_size)
  end
end
