class WebhooksController < ApplicationController

  def get_updates

    chat_id = params[:message][:from][:id] #get chat id from last received message
    user = params[:message][:text] #get user

      if mate = Mate.find_by(last_name: user) and mate.chat_id.nil? then # check if supplied user name is valid. Rights management to be added later!
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
      send_message(chat_id, "#{user} ???????????????\n Häää? >_>")
      send_message(chat_id, ">_<")
      send_message(chat_id, ":(")
      send_message(chat_id, "Was willst du mir sagen? Ich verstehe nicht...\nSprich doch mal mit meinem Papa Hans :)\n\nHerzlichst\nDein Putzbot")
    end

  end

  def remind_of_duties

    Mate.all.each do |mate|
      if mate.current_duty.due_to <= Time.zone.now + 5.hours && mate.balance != 2  # if due_to is 24:00, get's send at 21:00
        message = "Hi #{mate.first_name},\ndeine noch offene Aufgabe: #{mate.current_duty.area.name}\nBitte erledige sie, bzw. trage die Erledigung ein!\nLink: #{root_url + "##{mate.first_name.downcase}"}\nDanke!\nDein Putzbot\n\nSauberkeit: Wer reinigt, entfernt nichts, sondern verteilt nur anders."
        send_message(mate.chat_id, message) #needs to be replaced
        mate.update_attribute(:balance, 2) # workaround for marking that user was reminded
      end
    end

  end

end
