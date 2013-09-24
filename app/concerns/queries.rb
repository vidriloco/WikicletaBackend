module Queries
  module ClassMethods    
    def recent(current_user, opts={:only_owned => false})
      if current_user.nil? || current_user.city.nil?
        self.where('updated_at > ?', 1.month.ago).limit(10)
      else
        base_query = "#{self.to_s.downcase.pluralize}.updated_at > ? AND cities.id = ?"
        if opts[:only_owned]
          self.joins(:user).joins("LEFT JOIN cities ON users.city_id = cities.id").where(base_query, 1.month.ago, current_user.city.id).where('users.id' => current_user.id).limit(10)
        else
          self.joins(:user).joins("LEFT JOIN cities ON users.city_id = cities.id").where(base_query, 1.month.ago, current_user.city.id).limit(10)
        end
      end
    end
  end
  
  
  def self.included(base)
    base.extend(ClassMethods)
  end
end