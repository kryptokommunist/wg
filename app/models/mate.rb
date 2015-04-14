class Mate < ActiveRecord::Base
	validates :name, uniqueness: true
	validates :mobile_number, uniqueness: true

	has_many :duties
end
