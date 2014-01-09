class CyclePath < ActiveRecord::Base
  include Geography
  include Api
  
  attr_accessor :inverted
  
  has_many :users, :through => :ownerships
  has_many :ownerships, :as => :owned_object, :dependent => :destroy
  
  attr_accessible :name, :details, :path, :one_way, :kilometers, :updated_at, :inverted
  
  validates :name, :details, :path, :presence => true
  
  def self.filter_nearby(viewport)
    window=build_polygon_from_params(viewport)
    self.where{st_intersects(end_coordinate, window) | st_intersects(origin_coordinate, window)}
  end
  
  def owned_by?(user)
    return false if user.nil?
    !Ownership.where(:user_id => user.id, :owned_object_id => id, :owned_object_type => "CyclePath").empty?
  end
  
  def update_with(attrs, path)
    inverted = attrs.delete(:inverted)
    path = path.split(',').reverse.join(',') if inverted=="1"
    
    extract_and_set_coordinates(path)
    update_attributes(attrs.merge({:path => "LINESTRING(#{path})", :updated_at => Time.now}))
  end
  
  def self.new_with_path(params, user, path)
    cycle_path=CyclePath.new params.merge({:path => "LINESTRING(#{path})"})
    
    unless path.blank?
      cycle_path.extract_and_set_coordinates(path)
      cycle_path.ownerships.build(:user => user, :owned_object => cycle_path, :kind => Ownership.category_for(:owner_types, :submitter))
    end
    cycle_path
  end
  
  def extract_and_set_coordinates(path)
    coordinates_list = path.split(',')
    origin = coordinates_list[0]
    final = coordinates_list[coordinates_list.size-1]

    self.origin_coordinate = "POINT(#{origin})"
    self.end_coordinate = "POINT(#{final})"
  end
  
  def origin_lat
    origin_coordinate.lat
  end
  
  def origin_lon
    origin_coordinate.lon
  end
  
  def as_json(opts={})
    super({
      :only => [:id, :name, :details, :kilometers, :one_way],
      :methods => [:path_vector, :str_created_at, :str_updated_at, :origin_lat, :origin_lon, :owner]
    })
  end
  
  def path_vector
    points_list=[]
    return points_list if path.nil?
    
    path.points.each do |point|
      points_list << [point.x, point.y]
    end
    
    points_list
  end
end
