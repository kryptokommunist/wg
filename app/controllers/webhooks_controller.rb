class WebhooksController < ApplicationController

  def get_updates

    render :layout => false

    print params[:message]

  end

end
