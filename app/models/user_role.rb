class UserRole < ActiveRecord::Base
  belongs_to :user
  
  validates :user, :ring, :presence => true
  
  def self.superuser
    1
  end
  
  def self.read_write
    "rw"
  end
  
  def self.add_superuser(user)
    UserRole.create(:user => user, :ring => UserRole.superuser, :permissions => UserRole.read_write)
  end
end
