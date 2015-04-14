class Area < ActiveRecord::Base
	validates :name, uniqueness: true
	
	has_many :duties
end
