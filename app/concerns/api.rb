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
    default_user = defined?(user) ? user : nil
    if default_user.nil?
      if defined?(cycling_group_admins) && !cycling_group_admins.first.nil?
        default_user = cycling_group_admins.first.user 
      end
    end
    
    unless default_user.nil?
      ow = {:username => default_user.username, :id => default_user.id}
      return ow if default_user.picture.nil? || default_user.picture.image.nil? 
      ow.merge(:pic => default_user.picture.image.url(:mini_thumb))
    else
      owner_ = ownerships.where(:kind => Ownership.category_for(:owner_types, :owner)).first
      return owner_.fragments_in_hash unless owner_.nil?
      ownerships.where(:kind => Ownership.category_for(:owner_types, :submitter)).first.fragments_in_hash
    end
  end
  
  def light_fields
    { :title => light_title, :description => light_description, :lat => lat, :lon => lon, :str_updated_at => str_updated_at }
  end
  
  def light_title
    
  end
  
  def light_description
  
  end

end