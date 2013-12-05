module DiscoverHelper
  
  def select_a_city(city)
    return "Selecciona una ciudad" if city.nil?
    link_to city.name, 'javascript:void(0);', 
    {"data-lat"=>city.coordinates.lat, "data-lon"=>city.coordinates.lon, "id" => city.id}
  end
  
  def non_selected_cities_when_code_selected_is(city)
    cities = city.nil? ? City.order('name ASC') : City.order('name ASC').where(['name != ?', city.name])
        
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
  
  def url_to_share(item)
    if item.is_a? CyclingGroup
      discover_cycling_groups_url.concat("#/#{item.slug}")
    else
      discover_trips_url.concat("#/#{item.slug}")
    end
  end
end
