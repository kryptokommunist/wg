class DutiesController < ApplicationController

  def index
    @duties = Duty.all
  end

  def destroy
  	duty = Duty.find_by(id: params[:id])

  	@error = "Fehler beim Löschen!" unless duty && duty.destroy!

  	respond_to do |format|
		    format.js
	end
  end

end