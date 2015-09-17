class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_filter :force_tablet_to_mobile

  has_mobile_fu

# sends the given message with the help of a trello chat bot to the given chat id.
# if the chat_id is null it won't do anything
def send_message(chat_id, message, last_name: "")

  if chat_id
    #let's party hard!
    HTTParty.post('https://api.telegram.org/bot114815095:AAH0C9oMZKAEG4WMe4eZ9AmYHUZTrnJ1xCc/sendMessage', body: {chat_id: chat_id, text: message})
  else
    print("Error! No chat_id")
    @error = 'Bitte verbinde deinen Telegram-Account für Notifications mit dem <a href="https://telegram.me/kryptobot">Telegram Bot</a>! <p>1. Adde den Bot!</p><p>2. Schicke dem Bot deinen Nachnamen <b>' + last_name + '</b> als Nachricht!</p> '
  end

end

private
  def force_tablet_to_mobile
  	if is_tablet_device?
  		force_mobile_format
  	end
  end

end
