class WelcomeController < ApplicationController
  layout 'landing'
  
  before_filter :set_locale
  
  def index
    @cycling_groups = CyclingGroup.recent(10)
    @pois = (Workshop.recent(6)+Tip.recent(3)+Parking.recent(3)+@cycling_groups[0,5]).shuffle
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
