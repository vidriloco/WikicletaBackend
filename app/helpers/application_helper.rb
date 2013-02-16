module ApplicationHelper
  
  def is_section_active?(section)
    "active" if controller.controller_path.split('/')[0].eql?(section)
  end
  
  def provider_is?(provider)
    session["devise.oauth_data"][:provider].eql?(provider.to_s)
  end
  
  def errors_for(field, object)
    return "field-with-errors" unless object.errors[field].empty? 
  end
  
  def menu_section_for(section, namespace=nil)
    namespace = "#{namespace}_" if namespace
    selected = controller.controller_name=="#{section}" ? "selected" : ""
    out=content_tag(:p, link_to(t("app.sections.#{section}.title"), hash_link_for(eval("#{namespace}#{section}_path")), :class => selected))
    unless selected.blank?
      out += content_tag(:div, self.send("links_for_#{section}"), :class => "options")
    end
    out
  end
  
  def links_for_bikes
    out=  link_to(t('app.sections.bikes.subsections.new'), new_bike_path, current_action_matches?("new"))
    out+= link_to(t('app.sections.bikes.subsections.popular'), popular_bikes_path, current_action_matches?("popular"))
    #out+= link_to(t('app.sections.bikes.subsections.search'), search_bikes_path, class_selected.call("search"))
    out+= link_to(t('app.sections.bikes.subsections.mine'), mine_bikes_path, current_action_matches?("mine")) if user_signed_in?
    out
  end
  
  def links_for_places
    out=  link_to(t('app.sections.places.subsections.parking'), root_path, current_action_matches?("parking"))
    out+=  link_to(t('app.sections.places.subsections.bike_friendly'), root_path, current_action_matches?("bike_friendly"))
    out+= link_to(t('app.sections.places.subsections.search'), hash_link_for(map_incidents_path, 'search'), :id => 'places-search', :class => "highlighted")
    
    out
  end
  
  def links_for_routes
    out=  link_to(t('app.sections.routes.subsections.featured'), root_path, current_action_matches?("featured"))
    out+=  link_to(t('app.sections.routes.subsections.pooling'), root_path, current_action_matches?("pooling"))
    out+= link_to(t('app.sections.routes.subsections.search'), hash_link_for(map_incidents_path, 'search'), :id => 'routes-search', :class => "highlighted")
        
    out
  end
    
  def links_for_welcome
    out=  link_to(t('app.sections.welcome.subsections.about'), about_path, current_action_matches?("about"))
    out
  end
  
  def links_for_incidents  
    out= link_to(t('app.sections.incidents.subsections.stolen'), hash_link_for(map_incidents_path, 'thefts'), :id => 'incidents-thefts') 
    out+= link_to(t('app.sections.incidents.subsections.accidents'), hash_link_for(map_incidents_path, 'accidents'), :id => 'incidents-accidents')
    out+= link_to(t('app.sections.incidents.subsections.assaults'), hash_link_for(map_incidents_path, 'assaults'), :id => 'incidents-assaults') 
    out+= link_to(t('app.sections.incidents.subsections.regulation_infractions'), hash_link_for(map_incidents_path, 'regulation_infractions'), :id => 'incidents-regulation_infractions') 
    out+= link_to(t('app.sections.incidents.subsections.search'), hash_link_for(map_incidents_path, 'search'), :id => 'incidents-search', :class => "highlighted")
    out+= link_to(t('app.sections.incidents.subsections.new'), hash_link_for(map_incidents_path, 'new'), :id => 'incidents-new', :class => "highlighted")
    
    out
  end
  
  def links_for_highlights 
    out=  link_to(t('app.sections.highlights.subsections.recent'), root_path, current_action_matches?("featured"))
    out+=  link_to(t('app.sections.highlights.subsections.add'), root_path, current_action_matches?("pooling"))
    out+= link_to(t('app.sections.highlights.subsections.search'), hash_link_for(map_incidents_path, 'search'), :id => 'highlights-search', :class => "highlighted")
    out+= link_to(t('app.sections.highlights.subsections.new'), hash_link_for(map_incidents_path, 'new'), :id => 'highlights-new', :class => "highlighted")
    
    out
  end
  
  def hash_link_for(path, section=nil, resource=nil)
    return path+"#" if section.nil? && resource.nil?
    return path+"##{section}/#{resource}" unless resource.nil?
    path+"##{section}"
  end
  
  def shrink_text(text, max=65)
    if text.length > max
      until(text[max] == " ") do 
        max -= 1
      end
      "#{text[0, max]} ..."
    else
      text
    end
  end
  
  def top_section_menu_for(section, subsection=nil)
    render :partial => 'map/shared/top_menu', :locals => { :section => section, :subsection => subsection }
  end
  
  def boolean_options_for_select(selected)
    selected = selected ? "1" : "0"
    options_for_select({ t('common_answers')[true] => 1, t('common_answers')[false] => 0}, selected)
  end
  
  def currency_field_for(f, attribute, value, placeholder)
    out = "<span class='prefix'>$</span>" 
		out += f.text_field(attribute, :value => value, :placeholder => placeholder, :class => "inlined")
		out += "<span class='postfix'>#{t('currency.symbol.mexico')}</span><br/>"
		out.html_safe
  end
  
  private
  def current_action_matches?(action)
    {:class => "selected"} if action == controller.action_name
  end
end
