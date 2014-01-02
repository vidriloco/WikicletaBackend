class CycleStation < ActiveRecord::Base
  include Geography
  include Queries
  include Api
  
  def identifier
    "cycle_stations-#{id}"
  end
  
  def as_json(opts={})
    super({
      :only => [:name, :bikes_available, :free_slots, :agency],
      :methods => [:str_updated_at, :lat, :lon]
    })
  end
  
  def symbolized_status
    if(free_slots == 0 || bikes_available == 0)
      "bike_sharing_red"
    elsif ((free_slots*100)/capacity < 30) || ((bikes_available*100)/capacity < 30)
      "bike_sharing_yellow"
    else	
      "bike_sharing_green"
    end
  end
  
  def capacity
    free_slots+bikes_available
  end
end
