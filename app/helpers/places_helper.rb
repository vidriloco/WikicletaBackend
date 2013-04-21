module PlacesHelper
  def categories_for_select
    Category.all.inject({}) do |hash, f| 
      hash[I18n.t("categories.all.#{f.standard_name}").to_sym] = f.id
      hash
    end
  end
  
  def phones_for(place)
    if place.is_a? Workshop
      if !place.phone.blank? && !place.cell_phone.blank?
        "#{place.phone} #{t('connectives.and')} #{place.cell_phone}"
      elsif place.phone.blank? && place.cell_phone.blank?
        "---"
      else
        place.phone || place.cell_phone
      end
    end
  end
  
  def twitter_for(place)
    if place.is_a? Workshop
      twitter = "---"
      twitter = link_to("@#{place.twitter.gsub('@', '')}", "http://twitter.com/#{place.twitter.gsub('@', '')}", :target => "_blank") unless place.twitter.blank?
      twitter
    end
  end
  
  def webpage_for(place)
    if place.is_a? Workshop
      webpage = "---"
      webpage = link_to(place.webpage, place.webpage, :target => "_blank") unless place.webpage.blank?
      webpage
    end
  end
end