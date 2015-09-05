class WebhooksController < ApplicationController

  def get_updates

    chat_id = params[:message][:from][:id] #get chat id from last received message
    user = params[:message][:text] #get user

    if mate = Mate.find_by(last_name: user) then
      mate.update_attribute(chat_id: chat_id)
    end

  end

end
