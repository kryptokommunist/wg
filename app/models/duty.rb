class Duty < ActiveRecord::Base
	validates :area_id, presence: true
	validates :mate_id, presence: true
	validates :due_to, presence: true

	belongs_to :mate
	belongs_to :area
end
