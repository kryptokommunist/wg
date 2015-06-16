class Duty < ActiveRecord::Base
	validates :area_id, presence: true
	validates :mate_id, presence: true
	validates_uniqueness_of :accomplished_at, scope: :mate_id, conditions: -> { where(accomplished_at: nil) } # make sure there is only one open task

	before_destroy :check_if_assigned
											
	belongs_to :mate
	belongs_to :area

	# enforces the availabilty of one currently assigned duty, else mate.current_duty (and more) would break
	def check_if_assigned
		if self.accomplished_at.nil? 
			return false
		end
	end

end
