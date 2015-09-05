class WebhooksController < ApplicationController

  def handle_unverified_request
      forgery_protection_strategy.new(self).handle_unverified_request
  end

  def get_updates

    render :layout => false

    print "This is a test!"
    print params[:message]

  end

end
