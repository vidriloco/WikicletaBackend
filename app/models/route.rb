class Route < ActiveRecord::Base
  include Geography
  include Api
  
  has_many :route_performances, :dependent => :destroy
  
  has_many :users, :through => :ownerships
  has_many :ownerships, :as => :owned_object, :dependent => :destroy
  
  has_many :favorites, :as => :favorited_object, :dependent => :destroy
  has_many :ranked_comments, :as => :ranked_comment_object, :dependent => :destroy
  has_many :route_rankings
  validates :name, :details, :path, :presence => true
  
  def self.new_with(params, user)
    route_performance = params.delete(:route_performance)
    instants = params.delete(:instants)
    route = Route.new(params)
        
    route.route_performances.build(route_performance.merge(:user_id => user.id))
    route_performance=route.route_performances.first
    
    line_string_text = String.new
    instants.each do |instant|
      route_performance.instants.build({
        :speed => instant[:speed].to_f, 
        :elapsed_time => instant[:time].to_i, 
        :coordinates => "POINT(#{instant[:lon].to_f} #{instant[:lat].to_f})",
        :created_at => instant[:created_at],
        :updated_at => instant[:updated_at]
      })
      line_string_text+="#{instant[:lon].to_f} #{instant[:lat].to_f},"
    end
    
    route.origin_coordinate = "POINT(#{instants.first["lon"].to_f} #{instants.first["lat"].to_f})"
    route.end_coordinate = "POINT(#{instants.last["lon"].to_f} #{instants.last["lat"].to_f})"
    
    if(instants.size > 80)
      route.path = Geos::WktWriter.new.write(simplify_line("LINESTRING(#{line_string_text.chop!})")) 
    else
      route.path = "LINESTRING(#{line_string_text.chop!})"
    end
    
    route.ownerships.build(:user => user, :owned_object => route, :kind => Ownership.category_for(:owner_types, :submitter))
    
    route
  end
  
  def self.simplify_line(line,factor=0.00015)
    Geos::WktReader.new.read(line).simplify factor
  end
  
  def self.filter_nearby(viewport)
    window=build_polygon_from_params(viewport)
    self.where{st_intersects(end_coordinate, window) | st_intersects(origin_coordinate, window)}
  end
  
  def as_json
    super({
      :only => [:id, :name, :details, :kilometers, :likes_count, :dislikes_count, :comfort_index, :safety_index, :speed_index],
      :methods => [:str_created_at, :str_updated_at, :origin_lat, :origin_lon, :end_lat, :end_lon, :owner]
    })
  end
  
  def origin_lat
    origin_coordinate.lat
  end
  
  def origin_lon
    origin_coordinate.lon
  end
  
  def end_lat
    end_coordinate.lat
  end
  
  def end_lon
    end_coordinate.lon
  end
  
  def light_description
    details
  end
  
  def light_title
    name
  end
  
  def lat
    origin_lat
  end
  
  def lon
    origin_lon
  end
  
  def owned_by?(user)
    !Ownership.where(:user_id => user.id, :owned_object_id => id, :owned_object_type => "Route").empty?
  end
  
  def first_owner
    ownership = Ownership.where(:owned_object_id => id, :owned_object_type => "Route").first
    return nil if ownership.nil?
    ownership.user
  end
  
  def visible?(user)
    return true if is_public
    return owned_by?(user) unless user.nil?
    false
  end
  
  def extras(data=:path)
    return {:path => path_vector } if(data==:path)
    return {:performances => route_performances} if(data==:performances)
  end
  
  def path_vector
    points_list=[]
    
    path.points.each do |point|
      points_list << [point.x, point.y]
    end
    
    points_list
  end
  
  def to_points_list(style=:plain)
    points_list = style.eql?(:plain) ? String.new : Array.new
    return points_list if path.nil?
    path.points.each do |point|
      points_list << "#{point.y}|#{point.x} " if style.eql?(:plain)
      points_list << [point.y, point.x] if style.eql?(:json)
    end
    return points_list.chop if style.eql?(:plain)
    points_list
  end
  
  def to_gpx(performance_id)
    gpx=<<-eos
      
      <?xml version="1.0" encoding="UTF-8" standalone="no" ?>

      <gpx xmlns="http://www.topografix.com/GPX/1/1" xmlns:gpxx="http://www.garmin.com/xmlschemas/GpxExtensions/v3" xmlns:gpxtpx="http://www.garmin.com/xmlschemas/TrackPointExtension/v1" creator="Oregon 400t" version="1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd http://www.garmin.com/xmlschemas/GpxExtensions/v3 http://www.garmin.com/xmlschemas/GpxExtensionsv3.xsd http://www.garmin.com/xmlschemas/TrackPointExtension/v1 http://www.garmin.com/xmlschemas/TrackPointExtensionv1.xsd">
        <metadata>
          <link href="http://www.garmin.com">
            <text>Garmin International</text>
          </link>
          <time>%total_time%</time>
        </metadata>
        <trk>
          <name>%title%</name>
          <trkseg>
            %instants%
          </trkseg>
        </trk>
      </gpx>

    eos
    
    frags=<<-eos
    <trkpt lat="%lat%" lon="%lon%">
      <ele>0</ele>
      <time>%time%</time>
    </trkpt>
    eos
    
    instants_str=String.new
    
    performance_instants=route_performances.where(:id => performance_id).first.instants.order('elapsed_time ASC')
    
    performance_instants.each do |instant|
      instants_str << frags.gsub('%lat%', instant.lat.to_s).gsub('%lon%', instant.lon.to_s).gsub('%time%', instant.created_at.strftime("%Y-%m-%dT%TZ"))
    end
    
    gpx=gpx.gsub('%title%', name).gsub('%total_time%', performance_instants.last.created_at.strftime("%Y-%m-%dT%TZ")).gsub('%instants%', instants_str)
  end
  
  def filename_for_performace(performance_id)
    performance = route_performances.where(:id => performance_id).first
    "#{name}-#{performance.user.username}-#{performance.created_at.to_s}.gpx"
  end
  
  def update_with(attrs, path)
    extract_and_set_coordinates(path)
    update_attributes(attrs.merge(:path => "LINESTRING(#{path})"))
    self
  end
  
  def self.new_with(params, user, path)
    route=Route.new params.merge({:path => "LINESTRING(#{path})"})
    unless path.blank?
      route.extract_and_set_coordinates(path)
      route.ownerships.build(:user => user, :owned_object => route, :kind => Ownership.category_for(:owner_types, :submitter))
    end
    route
  end
  
  def extract_and_set_coordinates(path)
    origin_coordinate_ = path.split(',')[0]
    end_coordinate_ = path.split(',')[path.split(',').size-1]
    
    self.origin_coordinate = "POINT(#{origin_coordinate_.split(' ')[0].to_f} #{origin_coordinate_.split(' ')[1].to_f})"
    self.end_coordinate = "POINT(#{end_coordinate_.split(' ')[0].to_f} #{end_coordinate_.split(' ')[1].to_f})"
  end
end
