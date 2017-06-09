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
        html = render partial: "/waittimes/create.html.erb", locals: { customer: customer, waittime: waittime }, layout: false
    end
    # send_confirmation_sms(params[:phone_number])
    # render json: waittime.to_json
  end

  def send_notice(phone_number)
    send_ready_sms(phone_number)
  end

  def waittime_params
    params.require(:waittime).permit(:id)
  end
end
