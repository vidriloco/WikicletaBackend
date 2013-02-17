module Bike::Categories
  
  module ClassMethods
    def category_list_for(selector)
      self.send(selector)
    end
    
    def humanized_categories_for(selector, opts={})
      items = self.send(selector)
      items.keys.each.inject({}) do |collected, key|
        unless(opts[:except] && opts[:except].include?(items[key]))
          collected[key] = humanized_category_for(selector, items[key])
        end
        collected
      end
    end
    
    def category_for(selector, name)
      self.send(selector).invert[name]
    end
    
    def category_symbol_for(selector, identifier)
      self.send(selector)[identifier]
    end
    
    def humanized_category_for(selector, identifier)
      identifier = self.send(selector)[identifier] if identifier.is_a?(Integer)
      I18n.t("bikes.categories.#{selector.to_s}.#{identifier}")
    end
    
    private
    def statuses
      { 1 => :share, 2 => :rent, 3 => :sell }
    end
    
    def types
      { 1 => :urban, 2 => :mountain, 3 => :route, 4 => :fixie, 5 => :tandem, 6 => :cargo, 7 => :children, 8 => :bmx, 9 => :unicycle, 10 => :foldable, 11 => :other}
    end
    
    def locks
      { 1 => :none, 2 => :chain, 3 => :cable, 4 => :ulock }
    end
    
    # PDELETE
    def incidents
      { 1 => :theft, 2 => :assault, 3 => :accident, 4 => :breakdown }
    end
    
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
end