module Queries
  module ClassMethods    
    def recent(number)
      self.order('updated_at DESC').limit(number)
    end
  end
  
  
  def self.included(base)
    base.extend(ClassMethods)
  end
end