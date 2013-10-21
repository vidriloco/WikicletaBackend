# encoding: utf-8

FactoryGirl.define do
  factory :route_ranking_good, :class => "RouteRanking" do |rr|
    rr.speed_index      1
    rr.comfort_index    1
    rr.safety_index     1
  end
  
  factory :route_ranking_bad, :class => "RouteRanking" do |rr|
    rr.speed_index      3
    rr.comfort_index    3
    rr.safety_index     3
  end
end