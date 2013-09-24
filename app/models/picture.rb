require 'carrierwave/orm/activerecord'

class Picture < ActiveRecord::Base
  include Dumpable
  
  belongs_to :imageable, :polymorphic => true
  after_create :set_as_main_picture
  after_destroy :unset_as_main_picture
  
  #temporal
  attr_accessible :image, :remote_image_url, :image_cache, :remove_image
  
  mount_uploader :image, PictureUploader
  
  def self.new_from(params)
    picture=new(:image => params[:file])
    picture.apply_type_from(params)
    picture
  end
  
  def self.find_or_create_from(params)
    picture=new(:image => params[:file])
    picture.apply_type_from(params)
    
    # clear previously stored pics of a user or a cycling_group
    if picture.save!
      if params.has_key?(:user_id)
        Picture.where(:imageable_id => params[:user_id], :imageable_type => User.to_s).where('id != ?', picture.id).destroy_all
      elsif params.has_key?(:cycling_group_id)
        Picture.where(:imageable_id => params[:cycling_group_id], :imageable_type => CyclingGroup.to_s).where('id != ?', picture.id).destroy_all
      end
    end
  end
  
  def apply_type_from(params)
    if params.has_key?(:bike_id)
      self.imageable_id = params[:bike_id] 
      self.imageable_type = Bike.to_s
    elsif params.has_key?(:promoted_id)
      if params[:drop]
        # If issued a drop, then we know it's associated with a promoted record 
        promoted_id = params[:promoted_id]
        Promoted.find(promoted_id).pictures.destroy_all if promoted_id
      end
      self.imageable_id = params[:promoted_id] 
      self.imageable_type = Promoted.to_s
    elsif params.has_key?(:user_id)
      self.imageable_id = params[:user_id] 
      self.imageable_type = User.to_s
    elsif params.has_key?(:cycling_group_id)
      self.imageable_id = params[:cycling_group_id] 
      self.imageable_type = CyclingGroup.to_s
    end
  end
  
  def attached_to_user?
    self.imageable_type == User.to_s
  end
  
  def become_main_picture
    return if !imageable.respond_to?(:main_picture)
    imageable.update_attribute(:main_picture, self.id)
  end
  
  def main_picture?
    return if !imageable.respond_to?(:main_picture)
    imageable.main_picture == self.id
  end
  
  def self.attrs_for_dump
    %w(caption imageable_type updated_at created_at)
  end
  
  def self.attrs_for_dump_ex
    %w(imageable_id_to_s image_to_s)
  end
  
  def image_to_s
    return nil if image.nil? || image.url.nil?
    %-"#{image.url.split('/').last}"-
  end
  
  def imageable_id_to_s
    return nil if imageable.nil?
    if imageable.is_a? User
      "User.where(:username => '#{imageable.username}').first.id"
    elsif imageable.is_a? CyclingGroup
      "CyclingGroup.where(:slug => '#{imageable.slug}').first.id"
    else
      imageable.id
    end
  end
  
  private
  
  def set_as_main_picture
    return if !imageable.respond_to?(:main_picture)
    become_main_picture if imageable.main_picture.nil?
  end
  
  def unset_as_main_picture
    return if !imageable.respond_to?(:main_picture)
    imageable.update_attribute(:main_picture, nil) if main_picture?
  end
end
