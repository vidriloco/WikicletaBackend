class Workshop < ActiveRecord::Base
  include Shared::Geography
  
  validates_presence_of :name, :details
  
  belongs_to :user
  
  default_scope order('updated_at DESC')
  
  def store?
    store
  end 
  
  def identifier
    "workshop-#{id}"
  end
  
  def self.recent(current_user)
    if current_user.nil? || current_user.city.nil?
      Workshop.where('updated_at > ?', 1.month.ago).limit(10)
    else
      Workshop.joins(:user).joins("LEFT JOIN cities ON users.city_id = cities.id").where('workshops.updated_at > ?', 1.month.ago).limit(10)
    end
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
