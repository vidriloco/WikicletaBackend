class Instant < ActiveRecord::Base
  include Api
  include Geography
  
  belongs_to :route_performance
  belongs_to :user
  
  def self.bulk_create(params, user)
    instants = []
    params.each do |instant_params|
      lon = instant_params.delete(:longitude)
      lat = instant_params.delete(:latitude)
      instant = Instant.new_with(instant_params, {"lon" => lon, "lat" => lat}, user)
      instants << instant if instant.save
    end
    user.update_rankeables
    instants
  end
  
  def self.new_with(params, coords, user)
    instant=Instant.new(params.merge(:user => user))
    instant.apply_geo(coords)
    instant
  end
  
  def as_json
    super({
      :only => [:id, :elapsed_time],
      :methods => [:str_created_at, :speed_at, :lat, :lon]
    })
  end
  
  def self.avg(user)
    {:speed => Instant.where(:user_id => user.id, :created_at => Date.today.beginning_of_day..Date.today.end_of_day).average('speed'), 
     :distance => Instant.where(:user_id => user.id, :created_at => Date.today.beginning_of_day..Date.today.end_of_day).sum('distance')}
  end
  
  def speed_at
    speed.to_s
  end
end
