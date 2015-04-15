class Mate < ActiveRecord::Base
	validates :first_name, uniqueness: true
	validates :last_name, uniqueness: true
	validates :mobile_number, uniqueness: true

	has_many :duties
end
