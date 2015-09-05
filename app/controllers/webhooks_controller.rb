class WebhooksController < ApplicationController

  def get_updates

    render :layout => false

    print "This is a test!"
    print params[:message]

  end

end
