class StatusController < ApplicationController

	#respond_to :html, :js

	def show
		@mates = Mate.all
		@areas = Area.all
	end

end
