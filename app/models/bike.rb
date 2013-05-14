class Bike < ActiveRecord::Base
  include Shared::Categories
  include Shared::Queries
  
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
  
  default_scope order('updated_at DESC')
  scope :all_from_user, lambda { |user| where("user_id = ?", user.id) } 
  
  def self.fetch_stolen(user, status=false)
    status = (status == :include_recovered_ones_only)
    
    if user.nil? || user.city.nil?
      Bike.joins(:user => :incidents).where('incidents.solved' => status, 'incidents.kind' => Bike.category_for(:incidents, :theft))
    else
      Bike.joins(:incidents => :user).where(
      'incidents.solved' => status, 
      'incidents.kind' => Bike.category_for(:incidents, :theft), 
      'users.city_id' => user.city_id)
    end
  end
  
  def self.most_popular(user)
    if user.nil? || user.city.nil?
      order('likes_count DESC')
    else
      joins(:user).order('likes_count DESC').where('users.city_id' => user.city_id)
    end
  end
=begin  
  def self.for_sell_and_rent(user)
    if user.nil? || user.city.nil?
      Bike.uniq.joins(:bike_statuses).joins("LEFT JOIN incidents ON incidents.bike_id = bikes.id").where(
      'bike_statuses.concept' => [Bike.category_for(:statuses, :rent), Bike.category_for(:statuses, :sell)], 
      'bike_statuses.availability' => true).
      where('(incidents.solved = ? AND incidents.kind IN (?,?)) OR (incidents.solved = ? AND incidents.kind IN(?,?))', 
        true,
        Bike.category_for(:statuses, :rent), 
        Bike.category_for(:statuses, :sell),
        false,
        Bike.category_for(:statuses, :breakdown),
        Bike.category_for(:statuses, :assault))
    else
      Bike.uniq.joins(:bike_statuses, :user).where(
      'bike_statuses.concept' => [Bike.category_for(:statuses, :rent), Bike.category_for(:statuses, :sell)], 
      'bike_statuses.availability' => true,
      'users.city_id' => user.city_id)
    end
  end
=end

  def self.for_social_use(concepts, user)
    concepts.map! { |concept| Bike.category_for(:statuses, concept) }
    
    retrieved_objs = []
    if user.nil? || user.city.nil?
      retrieved_objs = Bike.uniq.joins(:bike_statuses).where(
      'bike_statuses.concept' => concepts, 
      'bike_statuses.availability' => true)
    else
      retrieved_objs = Bike.uniq.joins(:bike_statuses, :user).where(
      'bike_statuses.concept' => concepts, 
      'bike_statuses.availability' => true,
      'users.city_id' => user.city_id)
    end

    collection = []
    retrieved_objs.each do |bike|
      if bike.has_no_active_theft_or_breakdown_reports?
        collection << bike
      end
    end

    collection
  end
  
  def has_no_active_theft_or_breakdown_reports?
    incidents.where(:solved => false, :kind => [Bike.category_for(:incidents, :theft), Bike.category_for(:incidents, :breakdown)]).empty?
  end
  
  def last_theft_report
    incidents.where(:solved => false, :kind => Bike.category_for(:incidents, :theft)).last
  end
  
  def last_theft_recover_report
    incidents.where(:solved => true, :kind => Bike.category_for(:incidents, :theft)).last
  end
  
  def is_socialized?
    bike_statuses.where(:availability => true).count > 0
  end
  
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
  
  def bike_photo_url
    return nil if front_picture.nil? || front_picture.image.nil?
    front_picture.image.url(:mini_thumb)
  end
  
  def as_json(opts={})
    super({
      :only => [:name, :id, :likes_count],
      :methods => [:brand, :bike_photo_url, :updated_at_ms]
    })
  end
  
  protected
  def updated_at_ms
    "#{updated_at.to_time.to_i}"
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
