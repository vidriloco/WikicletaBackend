class WelcomeController < ApplicationController
  layout 'landing'
  
  def index
    redirect_to user_profile_path(current_user.username) if user_signed_in?
  end
  
  def about
  end
end
