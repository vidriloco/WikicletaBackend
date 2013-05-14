class MapsController < ApplicationController
  layout 'maps'
  
  protect_from_forgery :only => [:index]
  
  def index
    redirect_to maps_incidents_path
  end
end
