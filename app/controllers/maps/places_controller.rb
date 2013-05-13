class Maps::PlacesController < MapsController

  def index
    @workshops = Workshop.find_nearby(params[:viewport])
    @parkings = Parking.find_nearby(params[:viewport])
    @places_count = {:workshop => @workshops.size, :parking => @parkings.size, :bikefriendly_place => 0}
    @places = @workshops + @parkings

    respond_to do |format|
      format.js
      format.html
    end
  end
  
end