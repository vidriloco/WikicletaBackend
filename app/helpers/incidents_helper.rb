module IncidentsHelper
  
  def incident_types_for(incidents)
    incidents = [incidents] if incidents.is_a?(Symbol)
    with_incidents = incidents.each.inject("incident-selectable") do |collected,incident|
      collected += " incident-#{Bike.category_for(:incidents, incident)}"
      collected
    end
  end
  
  def current_user_has_bikes_to_report?
    if user_signed_in?
      !current_user.bikes.empty?
    end
  end
  
  # PDELETE
  def incidents_for_session_status
    if current_user_has_bikes_to_report?
      Bike.humanized_categories_for(:incidents).invert
    else
      Bike.humanized_categories_for(:incidents, :except => [:theft, :assault, :accident]).invert
    end
  end
  
  def humanized_dates_for_filter
    Incident.date_filtering_options.keys.each.inject({}) do |collected, key| 
      collected[key] = I18n.t("incidents.views.filtering.fields.date")[Incident.date_filtering_options[key]]
      collected
    end
  end
  
  def info_for(bike)
    "<div class='info to-left'>
    <span class='aspect'>#{t('bikes.views.preview.frame_number')}</span>
    <span class='frame'>#{bike.frame_number.blank? ? t('incidents.views.show.number_not_given') : bike.frame_number}</span>
    <span class='aspect'>#{t('bikes.views.preview.brand')}</span>
    <span class='brand'>#{bike.brand}</span>
    </div><div class='clear'></div>".html_safe
  end
  
  def number_of_comments_for(incident)
    count = incident.comments.count
    text = count == 1 ? t('comments.count.one') : t('comments.count.many', :number => count)
    "<i class='icon-comment'></i> ".html_safe + link_to("#{text}".html_safe, maps_incident_path(incident).concat('#/comments'))
    
  end
end
