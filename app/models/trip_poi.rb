class TripPoi < ActiveRecord::Base
  include Shared::Categories
  include Shared::Geography
  
  belongs_to :trip
  
  def identifier
    "#{category_symbol}-#{id}"
  end
  
  def title
    return "#{humanized_category} - #{name}" if category == TripPoi.category_for(:categories, :service_station)
    return humanized_category if(category == TripPoi.category_for(:categories, :paramedic) || category == TripPoi.category_for(:categories, :ambulance))
    name
  end
  
  def humanized_category
    TripPoi.humanized_category_for(:categories, category)
  end
  
  def category_symbol
    TripPoi.category_symbol_for(:categories, category)
  end
  
  private
  def self.categories
    { 1 => :service_station, 2 => :ambulance, 3 => :paramedic, 
      4 => :bike_lending, 5 => :direction_mark, 6 => :km_mark, 7 => :transport_connection, 8 => :sightseeing,
      9 => :start_flag, 10 => :finish_flag, 11 => :grouped_services, 12 => :cycling_learning, 13 => :free_grouped_services }
  end
end
