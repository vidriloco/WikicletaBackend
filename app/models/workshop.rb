class Workshop < ActiveRecord::Base
  include Shared::Geography
  include Shared::Queries
  
  validates_presence_of :name, :details
  
  belongs_to :user
  
  default_scope order('updated_at DESC')
  
  def store?
    store
  end 
  
  def identifier
    "workshop-#{id}"
  end
  
  def self.new_with(params, coords, user)
    workshop=Workshop.new(params.merge(:user => user))
    workshop.apply_geo(coords)
    workshop
  end
  
  def update_with(params, coordinates)
    self.apply_geo(coordinates)
    self.update_attributes(params)
  end
end
