module Shared::TimingCategories
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
  
  # String format is as follows
  # "dt\rt,ot" ~> day of week with recurrence and ocurrence
  # "d/rt"
  def build_timing_from_str(string)
    dt, rt, ot = string.split('|').map { |item| item.to_i }

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
    build_timing_from_str(periodicity)
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
end