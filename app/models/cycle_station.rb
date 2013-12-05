class CycleStation < ActiveRecord::Base
  include Geography
  include Queries
  include Api
  
  def as_json(opts={})
    super({
      :only => [:name, :bikes_available, :free_slots, :agency],
      :methods => [:str_updated_at, :lat, :lon]
    })
  end
end
