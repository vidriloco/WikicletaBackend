module WelcomeHelper
  def title_for_poi(poi)
    if poi.is_a? Parking
      t('app.categories.parkings.title')
    elsif poi.is_a? Tip
      t('app.categories.tips.title')
    elsif poi.is_a? Workshop
      poi.store? ? t('app.categories.workshops.store') : t('app.categories.workshops.workshop')
    end
  end
  
  def subtitle_for_poi(poi)
    if poi.is_a? Parking
      poi.humanized_kind
    elsif poi.is_a? Tip
      poi.humanized_category
    elsif poi.is_a? Workshop
      poi.name
    end
  end
  
  def details_for_poi(poi)
    splitted = nil
    if poi.is_a?(Parking) || poi.is_a?(Workshop)
      splitted = poi.details.split(' ')
    elsif poi.is_a? Tip
      splitted = poi.content.split(' ')
    end
    
    return splitted[0,12].join(' ').concat(' ...') if splitted.count > 12
    splitted.join(' ')
  end
  
  def icon_for_poi(poi)
    graphic_for_poi(poi).gsub('||', '-icon').downcase
  end
  
  def marker_for_poi(poi)
    graphic_for_poi(poi).gsub('||', '-marker').downcase
  end
  
  def graphic_for_poi(poi)
    if poi.is_a? Parking
      poi.humanized_kind_symbol.to_s.concat('_parking||.png')
    elsif poi.is_a? Tip
      poi.category_symbol.to_s.concat('||.png')
    elsif poi.is_a? Workshop
      'workshop||.png'
    end
  end
  
end
