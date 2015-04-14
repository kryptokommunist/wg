class StatusController < ApplicationController

	def show
		@mates = Mate.all
	end

end
