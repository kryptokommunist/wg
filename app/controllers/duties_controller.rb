class DutiesController < ApplicationController

  def index
    @duties = Duty.all
  end

  def destroy
  	duty = Duty.find_by(id: params[:id])

  	if duty && duty.destroy!
  		duty.mate.update_attribute(:points, duty.mate.points - duty.area.points)
  		@mate = duty.mate.reload
  	else
  		@error = "Fehler beim Löschen!"
  	end

  	respond_to do |format|
		    format.js
	end
  end

end