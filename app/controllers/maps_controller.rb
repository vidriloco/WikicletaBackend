class MapsController < ApplicationController
  layout 'maps'
  
  def index
    redirect_to maps_incidents_path
  end
end
