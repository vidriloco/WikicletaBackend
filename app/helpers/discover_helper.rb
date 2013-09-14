module DiscoverHelper
  
  def selected_city_by_code(city)
    return "Selecciona una ciudad" if city.nil?
    link_to t("cities.list.#{city.code}"), current_path.concat("#/#{city.code.split('_').join('/')}"), 
    {"data-lat"=>city.coordinates.lat, "data-lon"=>city.coordinates.lon}
  end
  
  def non_selected_cities_when_code_selected_is(city)
    cities = city.nil? ? City.all : City.where(['code != ?', city.code])  
        
    html=""
    cities.each do |city|
      html<<"<li>#{selected_city_by_code(city)}</li>"
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
end
