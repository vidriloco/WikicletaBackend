class City < ActiveRecord::Base
  include Geography
  include Dumpable
  
  has_many :users
  
  def self.find_city_on_country_with_code(country, code, user)
    default_city = "mx_df"
    if code.nil? || country.nil?
      return City.where(:code => default_city).first if(user.nil? || user.city.nil?)
      return user.city
    end
    City.where(:code => "#{country}_#{code}").first
  end
  
  def custom_json(morph=:default)
    if morph.eql?(:default)            
      trips_ = []
      trips.each do |trip|
        trips_ << trip.custom_json(:light)
      end
        
      return {:name => name, :trips => trips_ }
    end
  end
  
  def self.trips_to_json
    cities = City.all.each.inject([]) do |collected, city|
      collected << city.custom_json
    end
  end
  
  def self.attrs_for_dump
    %w(name country_code created_at updated_at alt_id)
  end
  
  def self.attrs_for_dump_ex
    %w(coordinates_to_s)
  end
end
