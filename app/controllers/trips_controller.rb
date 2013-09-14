class TripsController < ApplicationController
  layout 'discover'
  
  def index
    @trips = []
    
    respond_to do |format|
      format.js { @trips = Trip.find_nearby_with(params[:viewport], params[:extra]) }
      format.html
    end
    
  end
end
