class Maps::PlacesController < MapsController

  def index
    @workshops = Workshop.all
    @places_count = {:workshop => @workshops.size, :parking => 0, :bikefriendly_place => 0}
    @places = @workshops
  end
  
end