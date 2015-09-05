class WebhooksController < ApplicationController

  def get_updates

    print "This is a test!"
    print params[:message][:id]

    render :nothing => true

  end

end
