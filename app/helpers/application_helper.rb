module ApplicationHelper
  
  def on_path?(path)
    "active" if path==request.env['PATH_INFO']
  end
  
  def is_section_active?(section)
    "active" if controller.controller_path.split('/')[0].eql?(section)
  end
  
  def provider_is?(provider)
    session["devise.oauth_data"][:provider].eql?(provider.to_s)
  end
  
  def errors_for(field, object)
    return "field-with-errors" unless object.errors[field].empty? 
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
    options_for_select({ t('boolean_answers.accept') => 1, t('boolean_answers.decline') => 0}, selected)
  end
  
  def reporter_of(incident, extra="")
    if(incident.user != nil)
      link_to t('incidents.views.index.list.item.reporter.user', :user => incident.user.username), user_profile_path(incident.user.username).concat(extra)
    end
  end
  
  def currency_field_for(f, attribute, value, placeholder)
    html = <<-HTML
      <div class="control-group">
        <div class="controls">
          <span class='prefix'>$ </span>#{f.text_field(attribute, :value => value, :placeholder => placeholder, :class => "inlined")}
          <span class='postfix'>#{t('currency.symbol.mexico')}</span>
      	</div>
    	</div>
    HTML

    html.html_safe
  end
  
  def devise_error_messages_for(action)
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("user_accounts.errors_on.#{action}.title")

    html = <<-HTML
      <div id="error_explanation" class="alert alert-error error-explained">
        <h4 class="centered-text">#{sentence}</h4><br/>
        <ul>#{messages}</ul>
      </div>
    HTML

    html.html_safe
  end
  
  def current_user_equals(user)
    return false if user.nil?
    (user_signed_in? && user == current_user)
  end
  
  def back_bike_path(bike)
    return bikes_path if request.env['HTTP_REFERER'] == new_bike_url || request.env['HTTP_REFERER'] == edit_bike_url(bike)
    request.env['HTTP_REFERER']
  end
  
  def header_for_form(back_url, title)
    link_back = link_to(t('actions.back_arrow').html_safe, back_url)
    html = <<-HTML 
      <div class="row-fluid">
  			<ul class="nav nav-pills pull-left">
  				<li class="active">#{link_back}</li>
  	    </ul>
  			<div class="pull-right">
  				<h3>#{title}</h3>
  			</div>
  		</div>
    HTML
    
    html.html_safe
  end
  
  def instruction_for_form(title, extra)
    
    html = <<-HTML
      <div class="row-fluid instruction">
  			<div class="span6">
  				<p>#{title}</p>
  			</div>
  			<div class="span6">
  				#{extra}
  			</div>
  		</div>
    HTML
    
    html.html_safe
  end

  def user_default_city
    if !current_user.nil? && !current_user.city.nil?
      "<div id='selected-city' data-default-lat='#{current_user.city.coordinates.lat}' data-default-lon='#{current_user.city.coordinates.lon}'></div>".html_safe
    end
  end
  
  private
  def current_action_matches?(action)
    {:class => "selected"} if action == controller.action_name
  end
end
