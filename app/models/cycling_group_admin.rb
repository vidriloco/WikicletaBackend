class CyclingGroupAdmin < ActiveRecord::Base
  include Dumpable
  
  belongs_to :cycling_group
  belongs_to :user
  
  def self.attrs_for_dump
    %w(permissions verified updated_at created_at)
  end
  
  def self.attrs_for_dump_ex
    %w(cycling_group_id_to_s user_id_to_s)
  end
  
  def cycling_group_id_to_s
    return nil if cycling_group.nil?
    "CyclingGroup.where(:slug => '#{cycling_group.slug}').first.id"
  end
  
  def user_id_to_s
    return nil if user.nil?
    "User.where(:username => '#{user.username}').first.id"
  end
end
