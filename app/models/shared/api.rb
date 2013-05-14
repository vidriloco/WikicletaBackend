module Shared::Api

  def str_created_at
    created_at.to_s(:db)
  end
  
  def str_updated_at
    updated_at.to_s(:db)
  end

  def owner 
    payload = {:username => user.username, :id => user.id}
    return payload if user.picture.nil? || user.picture.image.nil? 
    payload.merge(:pic => user.picture.image.url(:mini_thumb))
  end
end