class Parking < ActiveRecord::Base
  include Shared::Categories
  include Shared::Geography
  
  validates_presence_of :coordinates, :kind
  belongs_to :user
  
  def identifier
    "parking-#{id}"
  end
  
  def humanized_kind
    Parking.humanized_category_for(:kinds, kind)
  end
  
  def self.new_with(params, coords, user)
    parking=Parking.new(params.merge(:user => user))
    parking.apply_geo(coords)
    parking
  end
  
  def update_with(params, coordinates, user)
    self.apply_geo(coordinates)
    self.update_attributes(params.merge(:user => user))
  end
  
  def self.kinds
    { 1 => :government_provided, 2 => :urban_mobiliary, 3 => :venue_provided }
  end
end
