class Bike < ActiveRecord::Base
  include Shared::Categories
  include Likes
  
  acts_as_commentable
  
  has_many :user_like_bikes, :dependent => :destroy
  has_many :bike_statuses, :dependent => :destroy
  has_many :pictures, :as => :imageable, :dependent => :destroy
  
  has_many :incidents, :dependent => :nullify
  #has_many :tweaks
  #has_many :borrows
  #has_many :usage_days
  #mileage
  belongs_to :bike_brand
  belongs_to :user
  
  validates_presence_of :name, :kind, :bike_brand, :user
    
  scope :most_popular, order('likes_count DESC')
  scope :all_from_user, lambda { |user| where("user_id = ?", user.id) } 
  
  def front_picture
    begin
      return Picture.find(self.main_picture)
    rescue
      nil
    end
  end
  
  def brand
    return if bike_brand.nil?
    bike_brand.name
  end
  
  def owner
    return if user.nil?
    user.username
  end
  
  def contact
    return "---" if(user.nil? || user.email.blank?)
    user.email
  end
  
  def self.new_with_owner(params, owner)
    new(params.merge(:user => owner))
  end
  
  def update_attributes_with_owner(params, owner)
    return self.update_attributes(params) if self.user = owner
    false
  end
  
  def self.humanized_category_for(selector, identifier)
    identifier = self.send(selector)[identifier] if identifier.is_a?(Integer)
    I18n.t("bikes.categories.#{selector.to_s}.#{identifier}")
  end
  
  private
  def self.statuses
    { 1 => :share, 2 => :rent, 3 => :sell }
  end
  
  def self.types
    { 1 => :urban, 2 => :mountain, 3 => :route, 4 => :fixie, 5 => :tandem, 6 => :cargo, 7 => :children, 8 => :bmx, 9 => :unicycle, 10 => :foldable, 11 => :other}
  end
  
  def self.locks
    { 1 => :none, 2 => :chain, 3 => :cable, 4 => :ulock }
  end
  
  # PDELETE
  def self.incidents
    { 1 => :theft, 2 => :assault, 3 => :accident, 4 => :breakdown }
  end
  
end
