class RouteRanking < ActiveRecord::Base
  belongs_to :route
  belongs_to :user
  
  validates :user, :route, :presence => true
  
  after_save :recalculate_fields
  after_destroy :recalculate_fields
  
  def self.new_or_find_with(params, user)
    existent_route_rankings = RouteRanking.where(:user_id => user.id, :route_id => params[:route_id])
    return existent_route_rankings.first unless existent_route_rankings.empty?
    return RouteRanking.new(params.merge(:user_id => user.id)) if existent_route_rankings.empty?
  end
  
  def save_or_update(params)
    params.delete(:route_id)
    return update_attributes(params) if persisted?
    save
  end
  
  def as_json(opts={})
    super({
      :only => [:id, :speed_index, :comfort_index, :safety_index, :route_id, :user_id]
    })
  end
  
  private
  def recalculate_fields
    route.update_attribute(:speed_index, RouteRanking.select('avg(speed_index) as speed_index').first.speed_index)
    route.update_attribute(:comfort_index, RouteRanking.select('avg(comfort_index) as comfort_index').first.comfort_index)
    route.update_attribute(:safety_index, RouteRanking.select('avg(safety_index) as safety_index').first.safety_index)
  end
end
