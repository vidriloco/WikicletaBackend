class Tip < ActiveRecord::Base
  include Categories
  include Geography
  include Queries
  include Api
  include Dumpable
  
  has_many :favorites, :as => :favorited_object, :dependent => :destroy
  
  validates_presence_of :coordinates, :content, :category, :user
  belongs_to :user
  
  #temporal
  #attr_accessible :content, :category, :updated_at, :created_at, :user
  
  default_scope order('updated_at DESC')
  
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
  
  def as_json(opts={})
    super({
      :only => [:id, :content, :category, :likes_count],
      :methods => [:str_created_at, :str_updated_at, :lat, :lon, :owner]
    })
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
  
  def owners 
    {}
  end
  
  def light_description
    content
  end
  
  def light_title
    category
  end
  
  # Dumpables
  def self.attrs_for_dump
    %w(content category likes_count updated_at created_at)
  end
  
  def self.attrs_for_dump_ex
    %w(coordinates_to_s user_id_to_s)
  end
  
  def user_id_to_s
    "User.where(:username => '#{user.username}').first.id"
  end
  
  private
  def self.categories
    { 1 => :danger, 2 => :alert, 3 => :sightseeing }
  end
end
