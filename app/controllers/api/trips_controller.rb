class Api::TripsController < Api::BaseController
  
  protect_from_forgery :except => [:show]
  
  def show
    @trip = Trip.find(params[:id])
    render :json => {:success => true, :trip => @trip.custom_json(:detailed) }, :status => :ok
  end

end