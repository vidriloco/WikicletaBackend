class ParkingsController < ApplicationController

  def index
    @parkings = []
    
    respond_to do |format|
      format.js do
        @parkings = Parking.find_nearby(params[:viewport])
      end
    end
  end
  
end