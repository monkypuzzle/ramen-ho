module SmsHelper

  def send_confirmation_sms(phone_number)
    @client = Twilio::REST::Client.new ENV['TWILIO_SSID'], ENV['TWILIO_TOKEN']
    @client.account.messages.create({
      from: "+#{ENV['TWILIO_PHONE_NUMBER']}",
      to: "+1" + phone_number,
      body: "You've been added to the waitlist! We'll let you know when your table's almost ready.",
      })
  end

  def send_ready_sms(phone_number)
    @client = Twilio::REST::Client.new ENV['TWILIO_SSID'], ENV['TWILIO_TOKEN']
    @client.account.messages.create({
      from: "+#{ENV['TWILIO_PHONE_NUMBER']}",
      to: "+1" + phone_number,
      body: "Your table is almost ready! Please stop by the restaurant to be seated",
      })
  end
end
