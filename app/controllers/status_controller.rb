class StatusController < ApplicationController

	def show
		@mates = Mate.all
		@areas = Area.all
		remind_of_duties(@mates)
	end

end
