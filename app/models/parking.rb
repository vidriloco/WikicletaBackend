class Parking < ActiveRecord::Base
  include Shared::Categories
  include Shared::Geography
  
  validates_presence_of :coordinates, :kind
  belongs_to :user
  
  default_scope order('updated_at DESC')
  
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
  
  def self.recent(current_user)
    if current_user.nil? || current_user.city.nil?
      Parking.where('updated_at > ?', 1.month.ago).limit(10)
    else
      Parking.joins(:user).joins("LEFT JOIN cities ON users.city_id = cities.id").where('parkings.updated_at > ? AND cities.id = ?', 1.month.ago, current_user.city.id).limit(10)
    end
  end
  
  def update_with(params, coordinates)
    self.apply_geo(coordinates)
    self.update_attributes(params)
  end
  
  def self.kinds
    { 1 => :government_provided, 2 => :urban_mobiliary, 3 => :venue_provided }
  end
end
