class WelcomeController < ApplicationController
  layout 'landing'
  
  before_filter :set_locale
  
  def index
    @cycling_groups = CyclingGroup.ten_recent
    @pois = (Workshop.recent(6)+Tip.recent(4)+Parking.recent(3)).shuffle
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
