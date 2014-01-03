class UserRole < ActiveRecord::Base
  belongs_to :user
  
  validates :user, :ring, :presence => true
  
  def self.superuser
    1
  end
  
  def self.city_organizer
    2
  end
  
  def self.read_write
    "rw"
  end
  
  def self.add_superuser(user)
    UserRole.create(:user => user, :ring => UserRole.superuser, :permissions => UserRole.read_write)
  end
  
  def self.add_city_organizer(user)
    UserRole.create(:user => user, :ring => UserRole.city_organizer, :permissions => UserRole.read_write)
  end
end
