class Duty < ActiveRecord::Base
	validates :area_id, presence: true
	validates :mate_id, presence: true
	validates_uniqueness_of :accomplished_at, scope: :mate_id, conditions: -> { where(accomplished_at: nil) } # make sure there is only one open task
											

	belongs_to :mate
	belongs_to :area
end
