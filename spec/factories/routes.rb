# encoding: utf-8

FactoryGirl.define do
  factory :route do |r|
    r.origin_coordinate "POINT(-100.3000 25.6667)"
    r.end_coordinate "POINT(-100.3000 25.6667)"
    r.name "The route to my work"
    r.details "Going through all the way long Insurgentes street"
    r.is_public true
    r.kilometers 10
    r.comfort_index 6
    r.speed_index 8
    r.safety_index 7
  end

end