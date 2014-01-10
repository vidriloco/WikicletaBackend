class TripsController < ApplicationController
  layout 'on_map_center'
  
  def index
    @trips = Trip.all
  end
end
