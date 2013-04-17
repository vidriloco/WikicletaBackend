# encoding: utf-8

FactoryGirl.define do
  factory :bike_share, :class => "BikeStatus" do |u|
    u.concept Bike.category_for(:statuses, :share)
    u.availability true
  end
  
  factory :bike_sell, :class => "BikeStatus" do |u|
    u.concept Bike.category_for(:statuses, :sell)
    u.availability true
  end
  
  factory :bike_rent, :class => "BikeStatus" do |u|
    u.concept Bike.category_for(:statuses, :rent)
    u.availability true
  end

end
