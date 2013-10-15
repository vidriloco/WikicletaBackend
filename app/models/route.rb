class Route < ActiveRecord::Base
  include Geography
  include Api
  
  has_many :route_performances, :dependent => :destroy
  has_many :ownerships, :as => :owned_object, :dependent => :destroy
  has_many :favorites, :as => :favorited_object, :dependent => :destroy
  
  validates :name, :details, :presence => true
  
  def self.new_with(params, user)
    route_performance = params.delete(:route_performance)
    instants = params.delete(:instants)
    route = Route.new(params)
        
    route.route_performances.build(route_performance.merge(:user_id => user.id))
    route_performance=route.route_performances.first
    
    line_string_text = String.new
    instants.each do |instant|
      route_performance.instants.build({
        :speed => instant[:speed].to_f, 
        :elapsed_time => instant[:time].to_i, 
        :coordinates => "POINT(#{instant[:lon].to_f} #{instant[:lat].to_f})" 
      })
      line_string_text+="#{instant[:lon].to_f} #{instant[:lat].to_f},"
    end
    
    route.origin_coordinate = "POINT(#{instants.first["lon"].to_f} #{instants.first["lat"].to_f})"
    route.end_coordinate = "POINT(#{instants.last["lon"].to_f} #{instants.last["lat"].to_f})"
    
    route.path = Geos::WktWriter.new.write(simplify_line("LINESTRING(#{line_string_text.chop!})"))
    route.ownerships.build(:user => user, :owned_object => route, :kind => Ownership.category_for(:owner_types, :submitter))
    
    route
  end
  
  def self.simplify_line(line,factor=0.00015)
    Geos::WktReader.new.read(line).simplify factor
  end
  
  def self.filter_nearby(viewport)
    window=build_polygon_from_params(viewport)
    self.where{st_intersects(end_coordinate, window) | st_intersects(origin_coordinate, window)}
  end
  
  def as_json
    super({
      :only => [:id, :name, :details, :kilometers],
      :methods => [:str_created_at, :str_updated_at, :origin_lat, :origin_lon, :end_lat, :end_lon, :owner]
    })
  end
  
  def origin_lat
    origin_coordinate.lat
  end
  
  def origin_lon
    origin_coordinate.lon
  end
  
  def end_lat
    end_coordinate.lat
  end
  
  def end_lon
    end_coordinate.lon
  end
  
  def light_description
    details
  end
  
  def light_title
    name
  end
  
  def lat
    origin_lat
  end
  
  def lon
    origin_lon
  end
  
  def extras(data=:path)
    return {:path => path_vector } if(data==:path)
    return {:performances => route_performances} if(data==:performances)
  end
  
  def path_vector
    points_list=[]
    
    path.points.each do |point|
      points_list << [point.x, point.y]
    end
    
    points_list
  end
end
