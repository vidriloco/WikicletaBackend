class Api::TripsController < Api::BaseController
    
  def index
    @trips = Trip.find_nearby_with(params[:viewport], params[:extras] || {})
    render :json => {:success => true, :trips => @trips.as_json}, :status => :ok
  end

end