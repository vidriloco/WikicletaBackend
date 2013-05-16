class Segment < ActiveRecord::Base
  belongs_to :trip
  
  def to_points_list(style=:plain)
    points_list = style.eql?(:plain) ? String.new : Array.new
    path.points.each do |point|
      points_list << "#{point.lat}|#{point.lon} " if style.eql?(:plain)
      points_list << [point.lat, point.lon] if style.eql?(:json)
    end
    return points_list.chop if style.eql?(:plain)
    points_list
  end
  
  def custom_json(morph=:default)
    if morph.eql?(:default)            
      {:id => id, :color => color, :details => details, :points => to_points_list(:json) }
    end
  end
end
