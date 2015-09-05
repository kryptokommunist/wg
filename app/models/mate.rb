class Mate < ActiveRecord::Base
	validates :first_name, uniqueness: true
	validates :last_name, uniqueness: true
	validates :mobile_number, uniqueness: true
	validates :chat_id, uniqueness: true

	has_many :duties

	# return the current open duty
	def current_duty
		self.duties.find_by(accomplished_at: nil)
	end
	
end
