class Incident < ActiveRecord::Base
  include Shared::Geography
  include Categories
  include Filtering
  
  acts_as_commentable
  
  belongs_to :user
  belongs_to :bike
  
  validates_presence_of :coordinates, :kind, :description
  validates_presence_of :lock_used, :if => :theft?
  validates_presence_of :bike, :if => :theft_or_assault_or_breakdown?
  validates_presence_of :user
  validates :vehicle_identifier, :format => /^[^-]([A-Z0-9\-]){3,}[^-]$/, :allow_blank => true
  
  attr_protected :user_id
  
  def self.new_with(params, coordinates, user)
    user = new(params.merge(:user => user)) 
    user.apply_geo(coordinates)
    user
  end
  
  def self.categorized_by_kinds
    hash = {}
    [:theft, :assault, :accident, :breakdown].each do |kind|
      hash[kind] = Incident.where(:kind => Bike.category_for(:incidents, kind)).count
    end
    hash
  end
  
  def owned_by_user?(passed_user)
    return false if passed_user.nil?
    user = passed_user
  end
  
  def is_bike_related?
    return !bike.nil?
  end
  
  def lat
    coordinates.lat
  end
  
  def lon
    coordinates.lon
  end
  
end
