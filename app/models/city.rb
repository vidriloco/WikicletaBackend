class City < ActiveRecord::Base
  include Shared::Geography
  
  has_many :users
  has_many :trips
  
  def name
    I18n.t("cities.list.#{code}")
  end
  
  def self.find_city_on_country_with_code(country, code, user)
    default_city = "mx_df"
    if code.nil? || country.nil?
      return City.where(:code => default_city).first if(user.nil? || user.city.nil?)
      return user.city
    end
    City.where(:code => "#{country}_#{code}").first
  end
end
