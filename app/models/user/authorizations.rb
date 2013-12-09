module User::Authorizations
  
  module ClassMethods
    def new_from_oauth_params(hash)
      case hash["provider"]
        when "twitter"
          info = hash["info"]
          new(:full_name => info["name"], :username => info["nickname"])
        when "facebook"
          info = hash["extra"]["raw_info"]
          new(:full_name => info["name"], :email => info["email"])
      end
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
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
  
end