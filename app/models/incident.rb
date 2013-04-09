class Incident < ActiveRecord::Base
  include Shared::Geography
  include Categories
  include Filtering
  
  acts_as_commentable
  
  belongs_to :user
  belongs_to :bike
  
  validates_presence_of :coordinates, :kind, :description
  validates_presence_of :lock_used, :if => :theft?
  validates_presence_of :bike, :if => :theft_or_breakdown?
  validates_presence_of :user
  validates :vehicle_identifier, :format => /^[^-]([A-Z0-9\-]){3,}[^-]$/, :allow_blank => true
  
  attr_protected :user_id
  
  def self.new_with(params, coordinates, user)
    incident = new(params.merge(:user => user)) 
    incident.apply_geo(coordinates)
    incident
  end
  
  def self.find_nearby(viewport=nil)
    if viewport.nil?
      self.all
    else
      self.filter_nearby(viewport)
    end
  end
  
  def update_with(params, coordinates, user)
    self.apply_geo(coordinates)
    self.update_attributes(params.merge(:user => user))
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
  
  def identifier
    "#{Bike.category_symbol_for(:incidents, kind)}-#{id}"
  end
  
end
