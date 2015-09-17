class WebhooksController < ApplicationController

  def get_updates

    chat_id = params[:message][:from][:id] #get chat id from last received message
    user = params[:message][:text] #get user

    if mate = Mate.find_by(last_name: user) and mate.chat_id.nil? then # check if supplied user name is valid. Rights management to be added later!
      mate.update_attributes(chat_id: chat_id)
      mate.reload
      send_message(mate.chat_id, "Hi #{mate.first_name},\ndein Account ist nun mit deinem Telegram-Account verbunden.\nLiebe Grüße und Viel Spaß beim putzen wünscht\nDein Putzbot")
    elsif mate # case there is already an chat_id assigned
      send_message(mate.chat_id, "Jemand hat versucht deine Telegram-Verbindung zu überschreiben. Seine Chat-ID lautet: #{chat_id}")
      send_message(chat_id, "Sorry, aber dieser Nutzer hat bereits einen assoziierten Telegram-Account!\nHerzlichst\nDein Putzbot")
    end

  end

end
