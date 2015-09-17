class WebhooksController < ApplicationController

  def get_updates

    chat_id = params[:message][:from][:id] #get chat id from last received message
    user = params[:message][:text] #get user

      if mate = Mate.find_by(last_name: user) and mate.chat_id.nil? then # check if supplied user name is valid. Rights management to be added later!
        begin
          mate.update_attributes!(chat_id: chat_id)
        rescue ActiveRecord::RecordInvalid => e
          send_message(chat_id, "Leider gab es Fehler o_O :\n\n#{e.to_s}")
        end

    elsif mate # case there is already an chat_id assigned
      send_message(mate.chat_id, "Hi #{mate.first_name},\njemand hat versucht deine Telegram-Verbindung zu überschreiben. Seine Chat-ID lautet: #{chat_id}")
      send_message(chat_id, "Sorry, aber dieser Nutzer hat bereits einen assoziierten Telegram-Account!\n\nHerzlichst\nDein Putzbot")
    else
      send_message(chat_id, "Was willst du mir sagen? Ich verstehe nicht...\nSprich doch mal mit meinem Papa Hans :)\n\nHerzlichst\nDein Putzbot")
    end

  end

end
