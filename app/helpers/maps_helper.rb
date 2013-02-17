module MapsHelper
  def dropdown_link_for(kind)
    category = Bike.category_for(:incidents, kind)
    link_to t("incidents.kinds.#{kind}.one"), "#/#{kind}", 
      "data-text" => t("incidents.kinds.#{kind}.one"), 
      :id => category, 
      "data-subroute" => Bike.category_symbol_for(:incidents, category).to_s, 
      :class => "#{kind}-selector"
  end
end
