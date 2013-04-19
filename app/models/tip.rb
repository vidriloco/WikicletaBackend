class Tip < ActiveRecord::Base
  include Shared::Categories
  include Shared::Geography
  
  validates_presence_of :coordinates, :content, :category
  belongs_to :user
  
  def self.new_with(params, coords, user)
    tip=Tip.new(params.merge(:user => user))
    tip.apply_geo(coords)
    tip
  end
  
  def self.categorized_by_kinds(viewport=nil)
    hash = {}
    if viewport.nil?
      [:danger, :alert, :sightseeing].each do |kind|
        hash[kind] = Tip.where(:category => Tip.category_for(:categories, kind)).count
      end
    else
      window=build_polygon_from_params(viewport)
      [:danger, :alert, :sightseeing].each do |kind_sym|
        hash[kind_sym] = self.where{st_intersects(coordinates, window) & (tips.category == Tip.category_for(:categories, kind_sym))}.count
      end
    end
    hash
  end
  
  def identifier
    "#{category_symbol}-#{id}"
  end
  
  def humanized_category
    Tip.humanized_category_for(:categories, category)
  end
  
  def category_symbol
    Tip.category_symbol_for(:categories, category)
  end
  
  def update_with(params, coordinates, user)
    self.apply_geo(coordinates)
    self.update_attributes(params.merge(:user => user))
  end
  
  private
  def self.categories
    { 1 => :danger, 2 => :alert, 3 => :sightseeing }
  end
end