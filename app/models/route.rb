class Route < ActiveRecord::Base
  has_many :route_performances, :dependent => :destroy
  has_many :ownerships, :as => :owned_object, :dependent => :destroy
  
  validates :name, :details, :presence => true
  
  def self.new_with(params, user)
    route_performance = params.delete(:route_performance)
    instants = params.delete(:instants)
    route=Route.new(params)
        
    route.route_performances.build(route_performance.merge(:user_id => user.id))
    route_performance=route.route_performances.first
    
    line_string_text = String.new
    instants.each do |instant|
      route_performance.instants.build({
        :speed => instant[:speed].to_f, 
        :elapsed_time => instant[:time].to_i, 
        :coordinates => "POINT(#{instant[:lon].to_f} #{instant[:lat].to_f})" 
      })
      line_string_text+="#{instant[:lon].to_f} #{instant[:lat].to_f},"
    end
    
    route.path = Geos::WktWriter.new.write(simplify_line("LINESTRING(#{line_string_text.chop!})"))
    route.ownerships.build(:user => user, :owned_object => route, :kind => Ownership.category_for(:owner_types, :submitter))
    
    route
  end
  
  def self.simplify_line(line,factor=0.00015)
    Geos::WktReader.new.read(line).simplify factor
  end
end
