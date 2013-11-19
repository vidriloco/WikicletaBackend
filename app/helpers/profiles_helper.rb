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
end