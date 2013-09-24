module Api

  def str_created_at
    created_at.to_s(:db)
  end
  
  def str_updated_at
    updated_at.to_s(:db)
  end

  def owners
    ownerz = []
    ownerships.each do |ownership|
      ownerz << ownership.fragments_in_hash
    end
    ownerz
  end
  
  def owner
    if defined?(user)
      ow = {:username => user.username, :id => user.id}
      return ow if user.picture.nil? || user.picture.image.nil? 
      ow.merge(:pic => user.picture.image.url(:mini_thumb))
    else
      owner_ = ownerships.where(:kind => Ownership.category_for(:owner_types, :owner)).first
      return owner_.fragments_in_hash unless owner_.nil?
      ownerships.where(:kind => Ownership.category_for(:owner_types, :submitter)).first.fragments_in_hash
    end
  end

end