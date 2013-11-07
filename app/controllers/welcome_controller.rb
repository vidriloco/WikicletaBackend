class WelcomeController < ApplicationController
  layout 'landing'
  
  before_filter :set_locale
  
  def index
    redirect_to user_profile_path(current_user.username) if user_signed_in?
  end
  
  def about
  end
  
  def signature
  end
  
  protected    
  def set_locale
    if params[:locale].blank?
      I18n.locale = :es_MX
    else
      I18n.locale = params[:locale]
    end
  end
end
