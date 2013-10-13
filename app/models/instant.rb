class Instant < ActiveRecord::Base
  include Api
  include Geography
  
  belongs_to :route_performance
  
  def as_json
    super({
      :only => [:id, :elapsed_time],
      :methods => [:str_created_at, :speed_at, :lat, :lon]
    })
  end
  
  def speed_at
    speed.to_s
  end
end
