class Trip < ActiveRecord::Base
  has_many :segments, :dependent => :destroy
  has_many :trip_pois
  belongs_to :city

  def self.all_on_city(name)
    City.where(:name => name).trips
  end
  
end
