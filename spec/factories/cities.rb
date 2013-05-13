# encoding: utf-8

FactoryGirl.define do
  factory :df, :class => "City" do |c|
    c.coordinates "POINT(-99.40 19.13)"
    c.code "mx_df"
  end
  
  factory :mty, :class => "City" do |c|
    c.coordinates "POINT(-100.3000 25.6667)"
    c.code "mx_mty"
  end
  
  factory :gdl, :class => "City" do |c|
    c.coordinates "POINT(-103.3519 20.6661)"
    c.code "mx_gdl"
  end
end
