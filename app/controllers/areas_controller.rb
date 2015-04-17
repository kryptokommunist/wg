class AreasController < ApplicationController

	def edit
		@area = Area.find_by(id: params[:id])
		@area.update_attribute(:clean, !@area.clean)

		respond_to do |format|
		    format.js
		end
	end

end