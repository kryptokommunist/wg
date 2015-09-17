class StatusController < ApplicationController

	def show
		@mates = Mate.all
		@areas = Area.all
	end

end
