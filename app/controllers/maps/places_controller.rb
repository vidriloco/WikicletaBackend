class Maps::PlacesController < MapsController

  def index
    @workshops = Workshop.all
    @parkings = Parking.all
    @places_count = {:workshop => @workshops.size, :parking => @parkings.size, :bikefriendly_place => 0}
    @places = @workshops + @parkings
  end
  
end