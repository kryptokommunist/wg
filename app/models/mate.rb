class Mate < ActiveRecord::Base
	validates :first_name, uniqueness: true
	validates :last_name, uniqueness: true
	validates :mobile_number, uniqueness: true
	validates :chat_id, uniqueness: true, allow_nil: true

	has_many :duties

	# return the current open duty
	def current_duty
		self.duties.find_by(accomplished_at: nil)
	end

  # returns next area_id out of 1..3
	def next_area_id
		next_id = current_duty.id + 1
		return next_id if (next_id <= 4)
		return 1
	end

end
