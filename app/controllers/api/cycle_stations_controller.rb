class Api::CycleStationsController < Api::BaseController
  
  protect_from_forgery :only => [:index]
    
  def index    
    @cycle_stations = CycleStation.find_nearby(params[:viewport])
    render :json => { :success => true, :cycle_stations => @cycle_stations.as_json }, :status => :ok
  end
end