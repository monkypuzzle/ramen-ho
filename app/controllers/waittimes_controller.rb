class WaittimesController < ApplicationController
  include SmsHelper

  def update
    waittime = Waittime.find(waittime_params[:id])
    waittime.update_attribute(:seated, true)
  end

  def create
    waittime = Waittime.new(party_size: params["customer"]["partySize"], restaurant_id: 1)
    customer = {name: params["customer"]["name"], phone: params["customer"]["phone"], party_size: waittime.party_size}
    if waittime.save
        # send_confirmation_sms(customer[:phone])
        render partial: "/waittimes/create.html.erb", locals: { customer: customer, waittime: waittime }, layout: false
    else
      # print error messages?
    end
  end

  def send_notice
    # send_ready_sms(params[:phone_number])
  end

  def waittime_params
    params.require(:waittime).permit(:id)
  end
end
