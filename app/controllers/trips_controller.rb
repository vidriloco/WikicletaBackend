class TripsController < ApplicationController
  layout 'discover'
  
  def index
    @trips = []
    
    respond_to do |format|
      format.js { @trips = Trip.find_nearby_with(params[:viewport], {:extras => params[:extra], :date => cookies[:date]}) }
      format.html { @city = City.find(cookies[:city_id]) unless cookies[:city_id].nil? }
    end
    
  end
end
