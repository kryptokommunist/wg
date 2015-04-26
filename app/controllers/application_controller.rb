class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :force_tablet_to_mobile

  has_mobile_fu

def remind_of_duties(mates)
  mates.each do |mate|
    if mate.current_duty.due_to <= Time.zone.now + 5.hours && mate.current_duty.accomplished_at.nil?  # if due_to is 24:00, get's send at 21:00
      message = "Hi #{mate.first_name},\ndeine noch offene Aufgabe: #{mate.current_duty.area.name}\nBitte erledige sie, bzw. trage die Erledigung ein!\nLink: #{root_url + "##{mate.first_name.downcase}"}\nDanke!\n\nSauberkeit: Wer reinigt, entfernt nichts, sondern verteilt nur anders."
      send_message(mate.mobile_number, message)
      mate.current_duty.update_attribute(:faulty, true)
    end
  end
end

# sends message via Twilio
def send_message(number, message)
  Thread.new do

    account_sid = 'AC2c8fd13944d9190874525dd9a0c5b339' 
    auth_token = '5a9d4063607d343906330171968f7371' 

    begin
      # set up a client to talk to the Twilio REST API
      client = Twilio::REST::Client.new account_sid, auth_token 

      client.account.messages.create({:from => '+4915735981100', 
        :to => number,
        :body => message,})

    rescue Exception => ex
      @error = ex.message + "\n\n" + ex.backtrace.join("\n")
    end

    ActiveRecord::Base.connection.close
  end
end

private
  def force_tablet_to_mobile
  	if is_tablet_device?
  		force_mobile_format
  	end
  end

end