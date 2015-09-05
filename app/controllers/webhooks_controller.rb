class WebhooksController < ApplicationController

  def get_updates

    print "This is a test!"
    print params[:message]

    render :nothing => true

  end

end
