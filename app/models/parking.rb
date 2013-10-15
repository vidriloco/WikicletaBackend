class Parking < ActiveRecord::Base
  include Categories
  include Geography
  include Queries
  include Api
  include Dumpable
  
  validates_presence_of :coordinates, :kind

  has_many :ownerships, :as => :owned_object, :dependent => :destroy
  has_many :favorites, :as => :favorited_object, :dependent => :destroy
  
  has_many :users, :through => :ownerships
  
  #temporal
  #attr_accessible :details, :kind, :has_roof, :created_at, :updated_at, :user
  
  default_scope order('updated_at DESC')
  
  def identifier
    "parking-#{id}"
  end
  
  def humanized_kind
    Parking.humanized_category_for(:kinds, kind)
  end
  
  def self.new_with(params, coords, user)
    parking=Parking.new(params)
    parking.apply_geo(coords)
    parking.ownerships.build(:user => user, :owned_object => parking, :kind => Ownership.category_for(:owner_types, :submitter))
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
  
  def light_description
    details
  end
  
  def light_title
    kind
  end
  
  def self.kinds
    { 1 => :government_provided, 2 => :urban_mobiliary, 3 => :venue_provided }
  end
  
  def self.attrs_for_dump
    %w(details kind has_roof likes_count created_at updated_at)
  end
  
  def self.attrs_for_dump_ex
    %w(coordinates_to_s)
  end
end
