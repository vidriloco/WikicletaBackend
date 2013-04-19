module Promoted::Likes
  
  def register_like_from(user)
    user_like_promoted=UserLikePromoted.create(:user => user, :promoted => self)
    
    if user_like_promoted.persisted?
      update_likes_count_by(1)
    end
  end
  
  def destroy_like_from(user)
    user_like_promoted=find_user_likes_promoted(user, self)
    unless user_like_promoted.nil?
      user_like_promoted.destroy
      
      if user_like_promoted.destroyed?
        update_likes_count_by(-1)
      end
    end
  end
  
  def is_liked_by?(user)
    return "requires_login weak" if user.nil?
    UserLikePromoted.status_for_pair(user, self)
  end
    
  private
  
  def find_user_likes_promoted(user, promoted)
    UserLikePromoted.find_by_user_id_and_promoted_id(user.id, promoted.id)
  end
  
  def update_likes_count_by(number)
    update_attribute(:likes_count,  likes_count+number) 
  end
end