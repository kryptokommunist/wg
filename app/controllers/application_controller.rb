class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :force_tablet_to_mobile

  has_mobile_fu
  

private
  def force_tablet_to_mobile
  	if is_tablet_device?
  		force_mobile_format
  	end
  end

end