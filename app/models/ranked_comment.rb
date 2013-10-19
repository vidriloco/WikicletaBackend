class RankedComment < ActiveRecord::Base
  
  belongs_to :ranked_comment_object, :polymorphic => true
  belongs_to :user
  
  validates :user, :presence => true
  
  after_save :increment_counters
  after_destroy :decrement_counters
  
  def self.new_with(params, user)
    RankedComment.new(params.merge(:user_id => user.id))
  end
  
  private
  def increment_counters
    if positive
      ranked_comment_object.update_attribute(:likes_count, ranked_comment_object.likes_count+1)
    else
      ranked_comment_object.update_attribute(:dislikes_count, ranked_comment_object.dislikes_count+1)
    end
  end
  
  def decrement_counters
    if positive
      ranked_comment_object.update_attribute(:likes_count, ranked_comment_object.likes_count-1)
    else
      ranked_comment_object.update_attribute(:dislikes_count, ranked_comment_object.dislikes_count-1)
    end
  end
  
end
