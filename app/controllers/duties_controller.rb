class DutiesController < ApplicationController

  def index
    @duties = Duty.all

  end


end