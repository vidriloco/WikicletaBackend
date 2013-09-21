class Trip < ActiveRecord::Base
  include Shared::Geography
  include Shared::Categories
  include Shared::TimingCategories
  
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :segments, :dependent => :destroy
  has_many :trip_pois

  def self.all_on_city(name)
    City.where(:name => name).trips
  end
  
  def as_json(opts={})
    super({
      :only => [:id, :name, :details, :periodicity],
      :include => [:trip_pois, :segments]
    })
  end
  
  def self.find_nearby_with(viewport, extras)
    trips = extras.has_key?(:slug) ? Trip.where(:slug => extras[:slug]) : find_nearby(viewport)
    
    trips.sort_by do |item| 
      item.number_of_days_to_event(Date.parse(extras[:date]))
    end
  end
  
  
  def custom_json(morph=:default)
    if morph.eql?(:light)
      {:id => id, :name => name, :days_to_event => days_to_event }
    elsif morph.eql?(:detailed)
      
      pois=trip_pois.each.inject([]) do |collected, trip_poi|
        collected << trip_poi.custom_json
      end
      
      segments_=segments.each.inject([]) do |collected, segment|
        collected << segment.custom_json
      end
      
      {:details => details, :trip_pois => pois, :segments => segments_ }
    end
  end
  
  protected

  def date_of_last_sunday
    date = Date.new(Date.today.year, Date.today.month, -1)
    last_month_day= date-date.wday
    last_month_day.day-Date.today.day
  end
  
  def date_of_next(day)
    date  = Date.parse(day)
    delta = date >= Date.today ? 0 : 7
    date + delta
  end
end
