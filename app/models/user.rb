class User < ActiveRecord::Base
  has_many :authorizations, :dependent => :destroy
  has_many :bikes, :dependent => :destroy
  has_many :user_like_bikes, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  
  has_many :recommendations
  has_many :places, :through => :recommendations
  
  has_many :place_comments
  has_many :places_commented, :through => :place_comments
  has_many :surveys
  
  has_many :incidents, :dependent => :destroy
  has_many :street_marks
  has_many :street_mark_rankings
  
  has_many :friendships
  has_many :friends, :through => :friendships
  
  devise :omniauthable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]
  attr_accessor :login
  attr_accessible :email, :password, :password_confirmation, :remember_me, :full_name, :username, :login, :bio, :personal_page, :externally_registered, :email_visible, :started_cycling_date
  validates_presence_of :username, :full_name
  validates_uniqueness_of :username
  
  before_validation :validate_format_of_username
  
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
  
  def is_seller?
    false
  end
  
  def email_visible?
    email_visible
  end
  
  def friendship_with(user=nil)
    Friendship.where('user_id = :me OR friend_id = :friend OR user_id = :friend OR user_id = :me', {:me => self.id, :friend => user.id}).first
  end
  
  def all_friendships
    Friendship.where('user_id = :me OR friend_id = :me', {:me => self.id})
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
    errors.add(:username, I18n.t('user_accounts.validations.invalid_username')) if self.username.match(/^\w{5,}$/).nil?
  end
end
