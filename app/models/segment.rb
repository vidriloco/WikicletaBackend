class Segment < ActiveRecord::Base
  belongs_to :trip
  
  def to_points_list
    points_list = String.new
    path.points.each do |point|
      points_list << "#{point.lat}|#{point.lon} "
    end
    points_list.chop
  end
end
