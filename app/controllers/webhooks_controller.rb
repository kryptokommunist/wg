class WebhooksController < ApplicationController

  def get_updates

    chat_id = params[:message][:from][:id] #get chat id from last received message
    text = params[:message][:text] #get text

    if text == "habs :)"

      if mate = Mate.find_by(chat_id: chat_id) then
        duty = mate.current_duty
        x = mate.duties.create(area_id: mate.next_area_id,
  									due_to: next_sunday(duty.due_to),
  									accomplished_by_assigned: true,
  									accomplished_at: nil,
  									faulty: false)
  			if x # make sure new duty was created

  				duty.update_attribute(:accomplished_at, Time.zone.now)
  				duty.area.update_attribute(:clean, true)
  				mate.update_attribute(:points, mate.points + duty.area.points)
  				duty.area.update_columns(last_cleaned: Time.zone.now, clean: true)

  				mate.reload # for access to new task in sms

  				message = """\nSuper #{mate.first_name},\nneuer Punktestand: #{mate.points}.\nDeine nächste Aufgabe: #{mate.current_duty.area.name}. \nDeadline: #{mate.duties.last.due_to.strftime("%a, %d.%m")}.\nLink: #{root_url + "##{mate.first_name.downcase}"}"""

  				send_message(mate.chat_id, message)
  				mate.notify(duty)
        else
          send_message(mate.chat_id, "Mir ist ein Fehler passiert... Mir ist es soooo peinlich :(\n Sorry")
        end
      else
        send_message(chat_id, "Du bist nichts als Nutzer eingetragen o_O")
      end
    elsif mate = Mate.find_by(last_name: text) and mate.chat_id.nil? then # check if supplied user name is valid. Rights management to be added later!
         begin
           mate.update_attributes!(chat_id: chat_id)
           mate.reload
           send_message(mate.chat_id, "Hey #{mate.first_name},\nich habe deinen Telegram-Account jetzt registriert \\o/. Leider bin ich sehr dumm. Ich kann leider noch nicht antworten. Mein Gehirn ist zu klein :(\n\nHDGL\n Dein Putzbot")
         rescue ActiveRecord::RecordInvalid => e
           send_message(chat_id, "Leider gab es Fehler o_O :\n\n#{e.to_s}")
         end

     elsif mate # case there is already an chat_id assigned
       send_message(mate.chat_id, "Hi #{mate.first_name},\njemand hat versucht deine Telegram-Verbindung zu überschreiben. Seine Chat-ID lautet: #{chat_id}")
       send_message(chat_id, "Sorry, aber dieser Nutzer hat bereits einen assoziierten Telegram-Account!\n\nHerzlichst\nDein Putzbot")
    else
      send_message(chat_id, "#{text} ???????????????\n Häää? >_>")
      send_message(chat_id, ">_<")
      send_message(chat_id, ":(")
      send_message(chat_id, "Was willst du mir sagen? Ich verstehe nicht...\nSprich doch mal mit meinem Papa Hans :)\n\nHerzlichst\nDein Putzbot")
    end

  end

  def remind_of_duties

    Mate.all.each do |mate|
      if mate.current_duty.due_to <= Time.zone.now + 5.hours  # if due_to is 24:00, get's send at 21:00
        message = "Hi #{mate.first_name},\ndeine noch offene Aufgabe: #{mate.current_duty.area.name}\nBitte erledige sie, bzw. trage die Erledigung ein oder antworte 'habs :)'!\nLink: #{root_url + "##{mate.first_name.downcase}"}\nDanke!\n\nDein Putzbot\n\nSauberkeit: Wer reinigt, entfernt nichts, sondern verteilt nur anders."
        send_message(mate.chat_id, message) #needs to be replaced
      end
    end

  end

  private

  # returns date for sunday 24:00pm of current week or of next week if supplied with due_to_date before now.
  # E.g. Function is called Monday at 00:00pm, then right_now needs to be incremented to next week (+7 days) since duties are assigned weekly
  def next_sunday(due_to_date)
    right_now = Time.zone.now
    right_now += 6.days if right_now <= due_to_date # approximation should be fine, ignore edge cases for now
    return right_now + (7 - right_now.wday).days + (22 - right_now.hour).hours + (0 - right_now.min).minutes + (0 - right_now.sec).second
  end

end
