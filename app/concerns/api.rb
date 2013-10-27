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
    if self.is_a?(Tip) || self.is_a?(RoutePerformance) || self.is_a?(RankedComment)
      return owner_hash_for(fallback_owner) if user.nil?
      return owner_hash_for(user)
    elsif self.is_a?(CyclingGroup)
      return owner_hash_for(cycling_group_admins.first.user) unless cycling_group_admins.empty?
    else
      ownership = ownerships.where(:kind => Ownership.category_for(:owner_types, :owner)).first
      ownership = ownerships.where(:kind => Ownership.category_for(:owner_types, :submitter)).first if ownership.nil?
      return owner_hash_for(fallback_owner) if ownership.nil?
      ownership.fragments_in_hash
    end
  end
  
  def owner_hash_for(default_user)
    ow = {:username => default_user.username, :id => default_user.id}
    if default_user.picture.nil? || default_user.picture.image.nil? 
      ow
    else
      ow.merge(:pic => default_user.picture.image.url(:mini_thumb))
    end
  end
  
  def fallback_owner
    User.where(:username => AppConfig.name).first
  end
  
  def light_fields
    { :title => light_title, :description => light_description, :lat => lat, :lon => lon, :str_updated_at => str_updated_at }
  end
  
  def light_fields_extra
    light_fields.merge({:kind => self.class.to_s})
  end
  
  def light_title
    
  end
  
  def light_description
  
  end

end