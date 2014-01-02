class DiscoverController < ApplicationController
  layout 'on_map_center'
  
  before_filter :set_locale

  def index
    @cycling_groups = []
    respond_to do |format|
      format.html 
      format.js do
        @cycling_groups = CyclingGroup.find_nearby_with(params[:viewport], {:extras => params[:extra], :date => cookies[:date]})
      end
    end
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
