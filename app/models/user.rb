class User < ActiveRecord::Base
  has_one :picture, :as => :imageable, :dependent => :destroy
  
  has_many :authorizations, :dependent => :destroy
  has_many :bikes, :dependent => :destroy
  
  has_many :user_like_bikes, :dependent => :destroy
  has_many :user_like_promoteds, :dependent => :destroy
  
  has_many :comments, :dependent => :destroy
  
  has_many :incidents, :dependent => :destroy
  has_many :tips, :dependent => :nullify
  has_many :workshops, :dependent => :nullify
  has_many :parkings, :dependent => :nullify
  
  belongs_to :city
  
  devise :omniauthable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable, :authentication_keys => [:login]
  attr_accessor :login, :invitation_code
  attr_accessible :invitation_code, :email, :password, :password_confirmation, :remember_me, :full_name, :username, :login, :bio, :personal_page, :externally_registered, :email_visible, :started_cycling_date, :city_id
  validates_presence_of :username, :full_name
  validates_uniqueness_of :username
  
  before_validation     :validate_format_of_username
  before_save           :ensure_authentication_token!, :on => :create
  before_validation     :validate_invitation_code
  
  
  def owns?(object)
    return if object.nil?
    object.send(:user) == self
  end
  
  def owns_comment?(comment)
    return false if comment.nil?
    comment.user == self
  end
  
  def owns_bike?(bike)
    return false if bike.nil?
    bike.user == self
  end

  def city_unset?
    city.nil?
  end
  
  def is_seller?
    false
  end
  
  def email_visible?
    email_visible
  end
  
  def as_json(opts={})
    super({
      :only => [:full_name, :email, :username],
      :methods => [:identifier, :auth_token, :created_at_ms]
    })
  end
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.strip.downcase }]).first
  end
  
  def self.new_from_oauth_params(hash)
    case hash["provider"]
      when "twitter"
        info = hash["info"]
        new(:full_name => info["name"], :username => info["nickname"])
      when "facebook"
        info = hash["extra"]["raw_info"]
        new(:full_name => info["name"], :email => info["email"])
    end
  end
  
  def add_authorization(session, attempt_save=false)
    generated_password = Devise.friendly_token.first(8)
    self.password, self.password_confirmation = [generated_password]*2
    authorization=self.authorizations.build(session)
    authorization.save if attempt_save
    authorization
  end
  
  def authorization_from(auth)
    authorizations=self.authorizations.where('provider = :provider', { :provider => auth })
    return nil if authorizations.empty?
    authorizations.first
  end
  
  def check_parameters_and_password(hash)
    return self.valid_password?(hash["current_password"]) if hash.has_key?("current_password")
    true
  end

  def validate_format_of_username
    return if self.username.nil?
    errors.add(:username, I18n.t('user_accounts.validations.invalid_username')) if self.username.match(/^\w{3,}$/).nil?
  end
  
  def profile_to_json
    {:city_name => city_name, :bikes => bikes_to_json, :user_pic => picture_img, :bio => bio }.to_json
  end
  
  protected
  
  def validate_invitation_code
    @sticker = Sticker.where(:code => invitation_code).first
    if !@sticker.nil? and @sticker.available?
      @sticker.update_attribute(:status, Sticker.category_for(:statuses, :claimed))
    else
      errors.add(:invitation_code, I18n.t('user_accounts.validations.invalid_invitation_code'))
    end
  end
    
  def city_name
    return nil if city_unset?
    city.name
  end
    
  def picture_img
    return nil if picture.nil? || picture.image.nil?
    picture.image.url(:mini_thumb)
  end
  
  def bikes_to_json
    bikes_json = []
    bikes.each do |bike|
      bikes_json << bike.as_json
    end
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
end
