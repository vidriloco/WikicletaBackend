class Authorization < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :uid, :provider, :token
  
  def self.create_with(user_id, auth_hash)
    return if auth_hash.nil?
    previous = find_by_provider_and_uid(auth_hash[:provider], auth_hash[:uid])
    previous.destroy if previous
    self.create(auth_hash.merge(:user_id => user_id))
  end
    
end