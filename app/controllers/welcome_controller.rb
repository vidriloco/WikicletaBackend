class WelcomeController < ApplicationController
  layout 'landing'
    
  def index
    @cycling_groups = CyclingGroup.recent(10)
    @pois = (Workshop.recent(6)+Tip.recent(3)+Parking.recent(3)+@cycling_groups[0,5]).shuffle
    redirect_to user_profile_path(current_user.username) if user_signed_in?
  end
  
  def about
  end
  
  def signature
  end
  
  def language
    I18n.locale = params[:locale]
    redirect_to root_path
  end
end
