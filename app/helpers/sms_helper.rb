module SmsHelper
  def send_confirmation_sms(phone_number)
    @client = Twilio::REST::Client.new ENV['TWILIO_SSID='], ENV['TWILIO_TOKEN']
    @client.account.messages.create({
      from: '+12138175925',
      to: "+1" + phone_number,
      body: "You've been added to the waitlist! We'll let you know when your table's almost ready.",
      })
  end
end
