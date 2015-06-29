class AddChatIdToMate < ActiveRecord::Migration
  def change
    add_column :mates, :chat_id, :integer
  end
end
