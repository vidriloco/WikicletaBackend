module MapsHelper
  def dropdown_link_for(kind)
    category = Bike.category_for(:incidents, kind)
    link_to t("incidents.kinds.#{kind}.one"), "#/#{kind}", 
      "data-text" => t("incidents.kinds.#{kind}.one"), 
      :id => category, 
      "data-subroute" => Bike.category_symbol_for(:incidents, category).to_s, 
      :class => "#{kind}-selector"
  end
  
  def navbar_map_for
    html = <<-HTML
    	<div class="pull-right">
    		<ul class="nav nav-pills">
    			<li class="active">#{active_link}</li>
    	  	<li class="dropdown">
    	  		<a class="dropdown-toggle"
    	  		data-toggle="dropdown"
    	  		href="#">#{ t('navbars.others') }<b class="caret"></b></a>
    	  	<ul class="dropdown-menu">
    				<li>#{link_for_section(:incidents)}</li>
    				<li>#{link_for_section(:places)}</li>
    				<li>#{link_for_section(:tips)}</li>
    				<li>#{link_for_section(:lanes)}</li>
    				<li>#{link_for_section(:routes)}</li>
    		  </ul>
    		  <li><a class='btn locate-me'><i class='icon icon-map-marker'></i> #{t('actions.locate_me')}</a></li>    		  
    			<!--<li><a href="#"><i class="icon-search"></i> #{ t('navbars.actions.filtering') }</a></li>-->
    		  </li>
    	  </ul>
    	</div>
    HTML
    
    html.html_safe
  end
  
  def partial_numbers_for(section, collection, kind)
    text = t("app.categories.#{section}.categories.#{kind}")
    text = text.pluralize if(collection[kind] != 1)
    
    path = send("maps_#{section}_path").concat('#/filter/').concat(kind.to_s.pluralize)
    
    result = "<a class='box #{kind}' href='#{path}'>
			<p class='number'>#{collection[kind]}</p>
			<p class='title'>#{text}</p>
		</a>"   
    result.html_safe
  end
  
  protected
  def link_for_section(section, override=false)
    section = section.to_sym
    link_to(t("navbars.maps.sections.#{section}"), send("maps_#{section}_path")) if(section != controller.controller_name.to_sym || override)
  end
  
  def active_link
    "<li class='active'>#{link_for_section(controller.controller_name, true)}</li>"
  end
end
