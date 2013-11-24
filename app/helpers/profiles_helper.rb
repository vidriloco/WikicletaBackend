module ProfilesHelper
  def url_for_route_preview(user, route)
    "#/route-preview/#{route.id}"
  end
  
  def url_for_cycling_group_preview(user, cycling_group)
    "#/cycling-group-preview/#{cycling_group.slug}"
  end
  
  def pluralized_link_name_for(collection, section)
    if section.eql?(:cycling_group)
      value = collection.length != 1 ? I18n.t('app.models.cycling_group.plural') : I18n.t('app.models.cycling_group.singular')
    elsif section.eql?(:route)
      value = collection.length != 1 ? I18n.t('app.models.route.plural') : I18n.t('app.models.route.singular')
    end
    
    "<p class='value'>#{collection.length}</p><p class='name'>#{value}</p>".html_safe
  end
  
  def circle_color_for(value)
    return image_tag('gray_ranking_icon.png') if value==0
    return image_tag('green_ranking_icon.png') if value==3
    return image_tag('yellow_ranking_icon.png') if value==2
    return image_tag('red_ranking_icon.png') if value==1
  end
  
  def ranking_status_for(route)
    if route.safety_index == 0 && route.speed_index == 0 && route.comfort_index == 0
      return "#{t('app.routes.rankings.none')} <i>(#{ link_to t('app.routes.rankings.from_app'), nil})</i>"
    else
      return "#{t('app.routes.rankings.some', :value => route.route_rankings.count)} <i>(#{t('app.routes.rankings.from_app')})</i>"
    end
  end
  
  def milliseconds_to_time(milis)
    seconds = milis / 1000
    minutes = seconds / 60
    seconds = seconds % 60

    timeString = ""

    if(minutes > 0 && minutes < 10)
  	   timeString = "0#{minutes}:"
    elsif(minutes >= 10) 
  	   timeString = "#{minutes}:"
    else
  	   timeString = "00:"
    end

    if (seconds < 10)
  	   timeString += "0#{seconds}"
    else
  	   timeString += seconds.to_s
    end
    timeString
  end
end