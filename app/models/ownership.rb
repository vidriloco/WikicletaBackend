class Ownership < ActiveRecord::Base
  include Categories
  include Dumpable
  
  belongs_to :owned_object, :polymorphic => true
  belongs_to :user
  
  def fragments_in_hash 
    ow = {:username => user.username, :id => user.id, :kind => kind}
    return ow if user.picture.nil? || user.picture.image.nil? 
    ow.merge(:pic => user.picture.image.url(:mini_thumb))
  end
  
  # Dump methods
  
  def self.attrs_for_dump
    %w(rank kind user_id updated_at created_at owned_object_type)
  end
  
  def self.attrs_for_dump_ex
    %w(owned_object_id_to_s)
  end
  
  def owned_object_id_to_s
    if imageable.is_a? User
      "User.where(:username => '#{imageable.username}').first.id"
    elsif imageable.is_a? CyclingGroup
      "CyclingGroup.where(:slug => '#{imageable.slug}').first.id"
    else
      imageable.id
    end
    "CyclingGroup.where(:slug => '#{cycling_group.slug}').first.id"
  end

  def self.populate_non_existent
    str = "Ownership.create(["
      [Parking, Workshop].each do |klass|
        klass.all.each do |object_m|
          str << "\n{:owned_object_id => #{id_for_object(object_m)}, :owned_object_type => '#{klass.to_s}', :user_id => User.where(:username => '#{object_m.user.username}').first.id, :kind => 1},"
        end
      end
    "#{str.chop}])"
  end
  
  def self.id_for_object(object_)
    %-#{object_.class.to_s}.where('ST_AsBinary(coordinates) = ST_AsBinary(ST_GeometryFromText(?))', "#{object_.coordinates}").first.id-
  end
  
  private
  def self.owner_types
    { 1 => :owner, 2 => :submitter, 3 => :contributor }
  end
end
