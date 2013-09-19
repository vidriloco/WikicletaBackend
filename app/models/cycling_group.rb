class CyclingGroup < ActiveRecord::Base
  include Shared::Categories
  include Shared::TimingCategories
  include Shared::Geography
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  has_many :cycling_group_admins
  has_many :users, :through => :cycling_group_admins
  
  has_one :picture, :as => :imageable, :dependent => :destroy
  
  validates_presence_of :coordinates, :name
  validates_uniqueness_of :name
  
  def self.find_nearby_with(viewport, extra=nil)
    return find_nearby(viewport) if extra.nil?

    CyclingGroup.where(:slug => extra)
  end
  
  def periodicity_for(symbol)
    return nil if periodicity.nil?
    dt, rt, ot = build_time_fragments(periodicity)
    if(symbol==:dt) 
      dt
    elsif(symbol==:rt)
      rt
    elsif(symbol==:ot)
      ot
    end
  end
  
  def meeting_time_fr(fragment)
    return nil if meeting_time.nil?
    time = meeting_time.split(':')
    { :hour => time[0], :minute => time[1] }[fragment]
  end
  
  def departing_time_fr(fragment)
    return nil if departing_time.nil?
    time = departing_time.split(':')
    { :hour => time[0], :minute => time[1] }[fragment]
  end
  
  def set_logo_and_user(pic_params, user)
    Picture.find_or_create_from(:cycling_group_id => id, :file => pic_params)
    CyclingGroupAdmin.create!(:user_id => user.id, :cycling_group_id => id)
  end
  
  def self.join_time(dictionary)
    "#{dictionary[:hour]}:#{dictionary[:minute]}"
  end
  
  def self.new_with(params, coords)    
    cycling_group=CyclingGroup.new(params.merge(CyclingGroup.fragments_for_timings(params)))
    cycling_group.apply_geo(coords)
    cycling_group
  end
  
  def self.those_riding_near(when_, where_)
    occurrences = Array.new
    if(when_ == :today)
      all.each do |group|
        schedule = IceCube::Schedule.new
        schedule.add_recurrence_rule group.timing_rule
        occurrences << group if schedule.occurs_on?(Date.today)
      end
    end
    occurrences
  end
  
  def self.fragments_for_timings(params)
    {:meeting_time => join_time(params.delete(:departing_time)), 
     :departing_time => join_time(params.delete(:meeting_time)), 
     :periodicity => build_timing_from_params(params.delete(:periodicity_tmp))}
  end

  def update_with(params, user)
    self.apply_geo(params[:coordinates])    
    cycling_group_params = CyclingGroup.fragments_for_timings(params[:cycling_group])
    if self.update_attributes(params[:cycling_group].merge(cycling_group_params))
      if(params.has_key?(:picture))
        Picture.find_or_create_from(:cycling_group_id => self.id, :file => params[:picture])
      end
      true
    else 
      false
    end
  end
end