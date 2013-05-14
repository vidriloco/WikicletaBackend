module Incident::Categories
  
  module ClassMethods
    def kind_for(number)
      Bike.category_for(:incidents, number)
    end
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
    
  def is_of_kind?(kind)
    symbol_kind==kind
  end
  
  def incidents
    { 1 => :theft, 2 => :assault, 3 => :accident, 4 => :breakdown }
  end
  
  def symbol_kind
    incidents[kind]
  end
  
  def theft?
    is_of_kind?(:theft)
  end
  
  def assault?
    is_of_kind?(:assault)
  end
  
  def accident?
    is_of_kind?(:accident)
  end
  
  def breakdown?
    is_of_kind?(:breakdown)
  end
  
  def theft_or_breakdown?
    theft? || breakdown?
  end
  
  def accident_or_breakdown?
    breakdown? || accident?
  end
  
  def accident_or_theft_or_assault?
    theft_or_assault? || accident?
  end
end