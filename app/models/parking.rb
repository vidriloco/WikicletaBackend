class Parking < ActiveRecord::Base
  include Shared::Categories
  include Shared::Geography
  include Shared::Queries
  include Shared::Api
  
  validates_presence_of :coordinates, :kind, :user
  belongs_to :user
  
  attr_accessible :details, :kind, :has_roof, :others_can_edit_it, :created_at, :updated_at, :user
  
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
  
  def update_with(params, coordinates)
    self.apply_geo(coordinates)
    self.update_attributes(params)
  end
  
  def as_json(opts={})
    super({
      :only => [:id, :details, :kind, :likes_count, :has_roof, :others_can_edit_it],
      :methods => [:str_created_at, :str_updated_at, :lat, :lon, :owner]
    })
  end
  
  def self.kinds
    { 1 => :government_provided, 2 => :urban_mobiliary, 3 => :venue_provided }
  end
end
