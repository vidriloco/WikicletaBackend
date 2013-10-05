module TimingCategories
  attr_accessor :calculated_days_to_event
  
  module ClassMethods    
    def day_timings
      { 1 => :mon, 2 => :tue, 3 => :wed, 4 => :thu, 5 => :fri, 6 => :sat, 0 => :sun }
    end
    
    def recurrence_timings
      { 1 => :monthly, 2 => :weekly, 3 => :yearly }
    end
    
    def ocurrence_timings
      { 1 => :first, -1 => :last }
    end
    
    def build_timing_from_params(dictionary)
      build_timing_from(dictionary[:day_timing], dictionary[:recurrence_timing], dictionary[:ocurrence_timing])
    end

    def build_timing_from(dt, rt, ot=nil)
      return "#{dt}|#{rt}|#{ot}" unless ot.nil?
      "#{dt}|#{rt}"
    end
  end
  
  def build_time_fragments(string)
    string.split('|').map { |item| item.to_i }
  end
  
  # String format is as follows
  # "dt\rt,ot" ~> day of week with recurrence and ocurrence
  # "d/rt"
  def build_timing_from_str(string)
    dt, rt, ot = build_time_fragments(string)
    if(self.class.category_symbol_for(:recurrence_timings, rt) == :monthly)
      unless ot.nil?
        return IceCube::Rule.monthly.day_of_week(dt => [ot]) 
      else
        return IceCube::Rule.monthly.day_of_month(dt) 
      end
    end
    IceCube::Rule.weekly.day(dt) if(self.class.category_symbol_for(:recurrence_timings, rt) == :weekly)
  end
  
  def timing_rule
    return nil if periodicity.split('|').empty?
    build_timing_from_str(periodicity)
  end
  
  def event_next_ocurrence_date
    schedule = IceCube::Schedule.new
    schedule.add_recurrence_rule timing_rule
    schedule.next_occurrence.to_date
  end
  
  def number_of_days_to_event(date=nil)
    return @calculated_days_to_event = 1000 if timing_rule.nil?
    schedule = IceCube::Schedule.new
    schedule.add_recurrence_rule timing_rule
    
    return @calculated_days_to_event = 0 if schedule.occurs_on?(date || Date.today)
    
    next_day_ocurring_from_today = schedule.next_occurrence(date || Date.today)
    @calculated_days_to_event = (next_day_ocurring_from_today.to_date-(date || Date.today)).to_i
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
end