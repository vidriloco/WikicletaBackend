module DiscoverHelper
  
  def select_a_city(city)
    return "Selecciona una ciudad" if city.nil?
    link_to t("cities.list.#{city.code}"), current_path.concat("#/#{city.code.split('_').join('/')}"), 
    {"data-lat"=>city.coordinates.lat, "data-lon"=>city.coordinates.lon}
  end
  
  def non_selected_cities_when_code_selected_is(city)
    cities = city.nil? ? City.all : City.where(['code != ?', city.code])  
        
    html=""
    cities.each do |city|
      html<<"<li>#{select_a_city(city)}</li>"
    end
    html.html_safe
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
  
  def url_to_share(cycling_group)
    discover_cycling_groups_url.concat("#/#{cycling_group.slug}")
  end
  
  def days_to_event(item, share_mode=nil)
    days = item.number_of_days_to_event
    
    connective = item.is_a?(Trip) ? I18n.t('app.events.connectives.trip') : I18n.t('app.events.connectives.cycling_group')
    
    if share_mode.nil?
      if days==0
        I18n.t('app.events.days_until.zero')
      elsif days==1
        I18n.t('app.events.days_until.one')
      else
        I18n.t('app.events.days_until.other', :days => days)
      end
    else
      if days==0
        I18n.t('app.events.share.days_until.zero').concat(connective).concat("#{item.name}")
      elsif days==1
        I18n.t('app.events.share.days_until.one').concat(connective).concat("#{item.name}")
      else
        I18n.t('app.events.share.days_until.other', :days => days).concat(connective).concat("#{item.name}")
      end
    end
  end
end
