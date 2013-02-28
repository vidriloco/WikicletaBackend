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
  
  def current_user_can(user)
    (user_signed_in? && user == current_user)
  end
  
  private
  def current_action_matches?(action)
    {:class => "selected"} if action == controller.action_name
  end
end
