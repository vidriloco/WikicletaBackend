module TripsHelper
  
  def selected_city_by_code(code)
    link_to t("cities.list.#{code}"), trips_country_city_code_path(*code.split('_'))
  end
  
  def non_selected_cities_when_code_selected_is(code)
    cities_code = [:mx_guadalajara, :mx_monterrey, :mx_df, :mx_aguascalientes]
    cities_code.delete(code.to_sym)
    
    html=""
    cities_code.each do |city_code|
      html<<"<li>#{selected_city_by_code(city_code.to_s)}</li>"
    end
    html.html_safe
  end
  
  def distance_in_days_according_to(period)
    days=0
    if period.eql?("last_sunday_month")
      date = Date.new(Date.today.year, Date.today.month, -1)
      last_month_day= date-date.wday
      days = last_month_day.day-Date.today.day
    elsif period.eql?("every_sunday")
      days = date_of_next("Sunday").day-Date.today.day
    end
   
    if days==0
      t('app.events.days_until.zero')
    elsif days==1
      t('app.events.days_until.one')
    else
      t('app.events.days_until.other', :days => days)
    end
  end
  
  def date_of_next(day)
    date  = Date.parse(day)
    delta = date >= Date.today ? 0 : 7
    date + delta
  end
  
  def trips_of_type_in(trip_pois, type)
    includes_type = false
    trip_pois.each do |trip_poi|
      if(trip_poi.category_symbol == type.to_sym)
        includes_type = true
      end
    end
    includes_type
  end
end
