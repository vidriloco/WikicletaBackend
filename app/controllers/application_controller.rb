class ApplicationController < ActionController::Base
  protect_from_forgery
  
  layout :layout_by_resource
  
  def after_sign_in_path_for(resource_or_scope)
    if user_signed_in?
      stored_location_for(resource_or_scope) || user_profile_path(current_user.username)
    elsif resource_or_scope.is_a?(AdminUser)
      admin_dashboard_path(resource_or_scope)
    end
  end
  
  protected

  def layout_by_resource
    if devise_controller?
      "no_bar"
    else
      "application"
    end
  end
end
  