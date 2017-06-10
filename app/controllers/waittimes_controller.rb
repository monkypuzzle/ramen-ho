class WaittimesController < ApplicationController
  include SmsHelper

  def update
    waittime = Waittime.find(waittime_params[:id])
    waittime.update_attribute(:seated, true)
  end

  def create
    @waittime = Waittime.new(waittime_params)
    @waittime.restaurant_id = current_admin.restaurant.id
    if @waittime.save
      # send_confirmation_sms(@waittime.phone)
      render partial: "/waittimes/create.html.erb", locals: {waittime: @waittime}, layout: false
    else
      render partial: "/waittime/errors.html.erb", locals: { waittime: @waittime}, layout: false
    end
  end

  def send_notice
    # send_ready_sms(params[:phone_number])
  end

  def waittime_params
    params.require(:waittime).permit(:id, :customer, :phone, :party_size)
  end
end
