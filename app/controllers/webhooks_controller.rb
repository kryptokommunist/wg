class WebhooksController < ApplicationController

  def get_updates

    print "This is a test!"
    print params[:message][:from][:id]

    render :nothing => true

  end

end
