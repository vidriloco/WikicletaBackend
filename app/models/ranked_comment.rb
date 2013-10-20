class RankedComment < ActiveRecord::Base
  include Api
  
  belongs_to :ranked_comment_object, :polymorphic => true
  belongs_to :user
  
  validates :user, :presence => true
  
  after_save :increment_counters
  after_destroy :decrement_counters
  
  def self.new_with(params, user)
    RankedComment.new(params.merge(:user_id => user.id))
  end
  
  def self.list(params)
    RankedComment.where({:ranked_comment_object_id => params[:ranked_comment_object_id], :ranked_comment_object_type => params[:ranked_comment_object_type]}).order('created_at DESC')
  end
  
  def as_json(opts={})
    super({
      :only => [:id, :content, :positive],
      :methods => [:str_created_at, :owner]
    })
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
