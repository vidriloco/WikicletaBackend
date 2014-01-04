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
end
