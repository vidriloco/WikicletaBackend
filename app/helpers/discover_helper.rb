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
  
  def cell_phone_for(workshop)
    cell_phone = workshop.cell_phone.to_i
    return image_tag('cell_phone_icon.png').concat(" <b>#{cell_phone}</b>".html_safe) if cell_phone != 0
    ""
  end
  
  def telephone_for(workshop)
    phone = workshop.phone.to_i
    return image_tag('telephone_icon.png').concat(" <b>#{phone}</b>".html_safe) if phone != 0 
    ""
  end
  
  def twitter_for(workshop)
    link_to(image_tag('twitter_icon.png'), "http://twitter.com/#{workshop.twitter}", :target => "_blank") unless workshop.twitter.blank?
  end
  
  def website_for(workshop)
    link_to(image_tag('website_icon.png'), workshop.webpage, :target => "_blank") unless workshop.webpage.blank?
  end
end
