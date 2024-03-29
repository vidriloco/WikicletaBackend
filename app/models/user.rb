class User < ActiveRecord::Base
  include Dumpable
  
  has_one :picture, :as => :imageable, :dependent => :destroy

  has_many :tips, :dependent => :nullify
  has_many :authorizations, :dependent => :destroy
  has_many :ownerships, :dependent => :destroy
  has_many :parkings, :through => :ownerships, :source => :owned_object, :source_type => 'Parking', :dependent => :nullify
  has_many :workshops, :through => :ownerships, :source => :owned_object, :source_type => 'Workshop', :dependent => :nullify
  has_many :cycle_paths, :through => :ownerships, :source => :owned_object, :source_type => 'CyclePath', :dependent => :nullify
  
  has_many :favorites, :dependent => :destroy
  has_many :favorited_routes, :through => :favorites, :source => :favorited_object, :source_type => 'Route', :dependent => :nullify
  
  has_many :route_rankings, :dependent => :destroy
  has_many :routes, :through => :route_rankings
  
  has_many :user_roles
  has_many :instants
    
  belongs_to :city
  
  has_many :cycling_group_admins, :dependent => :destroy
  has_many :cycling_groups, :through => :cycling_group_admins
  
  attr_accessor             :login
  #validates                :full_name, :presence => true
  validates                 :username, :presence => true
  validates_uniqueness_of   :username, :case_sensitive => false, :on => :create
  before_validation         :validate_format_of_username
  
  #temporal
  attr_accessible       :email, :distance, :speed, :guru_points, :password, :password_confirmation, :remember_me, :full_name, :username, :login, :bio, :personal_page, :externally_registered, :email_visible, :started_cycling_date, :city_id, :tracking_number, :tracking_number_last_reset_at
  before_save           :ensure_authentication_token!, :on => :create
  devise :omniauthable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :authentication_keys => [:login]
  before_save           :username_to_downcase
  
  def update_tracking_number
    number = (('a'..'z').to_a+(0..9).to_a).shuffle[0,6].join
    update_attributes({ :tracking_number => number, :tracking_number_last_reset_at => DateTime.now })
  end
  
  def last_tracking
    { :user => { :username => username, :image => picture_img }, :instant => instants.last.as_json  }
  end
  
  def owned_routes
    Route.joins(:ownerships).where('ownerships.user_id' => id)
  end
  
  def owns?(object)
    return if object.nil?
    object.send(:user) == self
  end
  
  def owns_route?(route)
    !Ownership.where(:user_id => id, :owned_object_id => route.id, :owned_object_type => "Route").empty?
  end
  
  def owns_comment?(comment)
    return false if comment.nil?
    comment.user == self
  end
  
  def admins_cycling_group?(cg)
    !CyclingGroupAdmin.where(:user_id => id, :cycling_group_id => cg.id).empty?
  end
  
  def activities
    { :cycling_groups => cycling_groups }
  end

  def city_unset?
    city.nil?
  end
  
  def email_visible?
    email_visible
  end
  
  def check_parameters_and_password(hash)
    return self.valid_password?(hash["current_password"]) if hash.has_key?("current_password")
    true
  end
  
  def superuser?
    !user_roles.where(:ring => UserRole.superuser, :permissions => UserRole.read_write).empty?
  end
  
  def update_rankeables
    distance = Instant.instants_with(id, {:speed => 35, :timing => 1000}).sum('distance')
    speed = Instant.instants_with(id, {:speed => 35, :timing => 1000}).average('speed')
    update_attributes({:distance => distance,  :speed => speed})
  end
  
  # Methods that generate content for API
  
  def self.create_with(registration, authorization=nil)
    user = User.new(registration)
    user.save
    user.set_pic(registration)
    Authorization.create_with(user.id, authorization)
    user
  end
  
  def as_json(opts={})
    super({
      :only => [:full_name, :email, :username, :bio],
      :methods => [:identifier, :auth_token, :created_at_ms]
    })
  end
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.strip.downcase }]).first
  end
  
  def profile_to_json
    out = {:city_name => city_name, :user_pic => picture_img, :username => username, :bio => bio, :updated_at => updated_at.to_s(:db), :identifier => identifier, :email => email }
    out.merge!(:speed => speed.to_s) unless speed.nil?
    out.merge!(:distance => distance.to_s) unless distance.nil?
    out
  end
  
  def update_with(params)
    set_pic(params)
    update_attributes!(params)
  end
  
  def set_pic(params)
    assign_picture(build_dummy_tmp_file_from(params)) unless params[:image_pic].blank?
  end
  
  # End methods that generate content for API
  
  def picture_img
    return nil if picture.nil? || picture.image.nil?
    picture.image.url(:mini_thumb)
  end
  
  def can_contribute_to_city?
    !user_roles.where(:ring => [UserRole.city_organizer, UserRole.superuser]).empty?
  end
  
  protected
  
  def username_to_downcase
    username.downcase!
  end
  
  def validate_format_of_username
    return if self.username.nil?
    errors.add(:username, I18n.t('user_accounts.validations.invalid_username')) if self.username.match(/^\w{3,}$/).nil?
  end
  
  def build_dummy_tmp_file_from(params)
    tempfile = Tempfile.new("file")
    tempfile.binmode
    tempfile.write(Base64.decode64(params.delete(:image_pic)))
    ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, :filename => "tmpfile-name.jpg", :original_filename => "original-tmpfile.jpg")
  end
  
  def assign_picture(pic_on_file)
    Picture.find_or_create_from({:user_id => id, :file => pic_on_file})
  end
    
  def city_name
    return nil if city_unset?
    city.name
  end
  
  def auth_token
    authentication_token
  end
  
  def created_at_ms
    "#{created_at.to_time.to_i}"
  end
  
  def identifier
    "#{id}"
  end
  
  # Dumpables
  
  def self.attrs_for_dump
    %w(city_id email full_name username encrypted_password reset_password_token reset_password_sent_at remember_created_at sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip last_sign_in_ip authentication_token bio personal_page started_cycling_date created_at updated_at)
  end
  
  def self.attrs_for_dump_ex
    []
  end
end
