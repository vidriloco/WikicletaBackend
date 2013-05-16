class Trip < ActiveRecord::Base
  has_many :segments, :dependent => :destroy
  has_many :trip_pois
  belongs_to :city

  def self.all_on_city(name)
    City.where(:name => name).trips
  end
  
  def as_json(opts={})
    super({
      :only => [:id, :name, :details, :periodicity],
      :include => [:trip_pois, :segments]
    })
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
  
  def days_to_event
    days=0
    if periodicity.eql?("last_sunday_month")
      days = date_of_last_sunday
    elsif periodicity.eql?("every_sunday")
      days = date_of_next("Sunday").day-Date.today.day
    end
   
    if days==0
      I18n.t('app.events.days_until.zero')
    elsif days==1
      I18n.t('app.events.days_until.one')
    else
      I18n.t('app.events.days_until.other', :days => days)
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
