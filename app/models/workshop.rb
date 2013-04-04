class Workshop < ActiveRecord::Base
  include Shared::Geography
  
  validates_presence_of :name, :details
  
  belongs_to :user
  
  def store?
    store
  end 
  
  def self.new_with(params, coords, user)
    workshop=Workshop.new(params.merge(:user => user))
    workshop.apply_geo(coords)
    workshop
  end
  
  def update_with(params, coordinates, user)
    self.apply_geo(coordinates)
    self.update_attributes(params.merge(:user => user))
  end
end
