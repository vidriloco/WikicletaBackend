module TripsHelper
  
  def selected_city_by_code(code)
    link_to t("cities.list.#{code}"), trips_country_city_code_path(*code.split('_'))
  end
  
  def non_selected_cities_when_code_selected_is(code)
    cities_code = [:mx_guadalajara, :mx_monterrey, :mx_df]
    cities_code.delete(code.to_sym)
    
    html=""
    cities_code.each do |city_code|
      html<<"<li>#{selected_city_by_code(city_code.to_s)}</li>"
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
