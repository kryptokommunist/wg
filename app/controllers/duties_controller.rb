class DutiesController < ApplicationController

  def index
    @duties = Duty.all
  end

  def destroy
  	duty = Duty.find_by(id: params[:id])

  	if duty && duty.destroy
  		duty.mate.update_attribute(:points, duty.mate.points - duty.area.points)
  		@mate = duty.mate.reload
  	else
      if duty # case destroy didn't work
  		  @error = "Fehler beim Löschen! Element darf nicht gelöscht werden."
      else
        @error = "Fehler beim Löschen! Element nicht gefunden."
      end
  	end

  	respond_to do |format|
		    format.js
	end
  end

end