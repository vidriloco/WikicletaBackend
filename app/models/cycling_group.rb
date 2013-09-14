class CyclingGroup < ActiveRecord::Base
  include Shared::Categories
  include Shared::TimingCategories
  include Shared::Geography
  
  has_many :cycling_group_admins
  has_many :users, :through => :cycling_group_admins
  
  has_one :picture, :as => :imageable, :dependent => :destroy
  
  validates_presence_of :coordinates, :name
  
  
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
  
  # String format is as follows
  # "dt\rt,ot" ~> day of week with recurrence and ocurrence
  # "d/rt"
  def build_timing_from_str(string)
    dt, rt, ot = string.split('|').map { |item| item.to_i }
    
    return IceCube::Rule.monthly.day_of_month(dt => [ot]) if(CyclingGroup.category_symbol_for(:recurrence_timings, rt) == :monthly)
    IceCube::Rule.weekly.day(dt) if(CyclingGroup.category_symbol_for(:recurrence_timings, rt) == :weekly)
  end
  
  def timing_rule
    build_timing_from_str(periodicity)
  end
  
  def self.new_with(params, coords)
    departing_time = join_time(params.delete(:departing_time))
    meeting_time = join_time(params.delete(:meeting_time))
    periodicity = build_timing_from_params(params.delete(:periodicity_tmp))
    
    cycling_group=CyclingGroup.new(params.merge(
      :meeting_time => meeting_time, 
      :departing_time => departing_time,
      :periodicity => periodicity
    ))
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

  
end
