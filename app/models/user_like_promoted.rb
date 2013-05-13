class UserLikePromoted < ActiveRecord::Base
  belongs_to :promoted
  belongs_to :user
  
  validates_presence_of :promoted, :user
  before_validation :check_uniqueness
  
  def self.status_for_pair(user, promoted)
    return "strong" if self.find_by_user_id_and_promoted_id(user.id, promoted.id)
    "weak"
  end
  
  private
  def check_uniqueness
    errors.add(:base, "Not Unique") if UserLikePromoted.find_by_user_id_and_promoted_id(user.id, promoted.id)
  end
  
end
