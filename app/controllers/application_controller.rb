class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :force_tablet_to_mobile

  has_mobile_fu

def remind_of_duties(mates)

  mates.each do |mate|
    if mate.current_duty.due_to <= Time.zone.now + 5.hours && mate.balance != 2  # if due_to is 24:00, get's send at 21:00
      message = "Hi #{mate.first_name},\ndeine noch offene Aufgabe: #{mate.current_duty.area.name}\nBitte erledige sie, bzw. trage die Erledigung ein!\nLink: #{root_url + "##{mate.first_name.downcase}"}\nDanke!\n\nSauberkeit: Wer reinigt, entfernt nichts, sondern verteilt nur anders."
      #send_message(mate.mobile_number, message) #needs to be replaced
      mate.update_attribute(:balance, 2) # workaround for marking that user was reminded
    end
  end
      
end


private
  def force_tablet_to_mobile
  	if is_tablet_device?
  		force_mobile_format
  	end
  end

end