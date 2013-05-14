class TripsController < ApplicationController
  layout 'trips'
  
  def index
    @city = City.find_city_on_country_with_code(params[:country_code], params[:city_code], current_user)
  end
  
  def show
    @trip = Trip.find(params[:id])
  end
end
