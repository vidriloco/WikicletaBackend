class Api::CitiesController < Api::BaseController
  
  protect_from_forgery :except => [:index]
  
  def index
    render :json => {:success => true, :city_trips => City.trips_to_json }, :status => :ok
  end

end