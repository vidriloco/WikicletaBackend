class CycleStationsController < ApplicationController

  def index
    @cycle_stations = []
    
    respond_to do |format|
      format.js do
        @cycle_stations = CycleStation.find_nearby(params[:viewport])
      end
    end
  end
  
end