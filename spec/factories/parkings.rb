# encoding: utf-8

FactoryGirl.define do
  factory :parking, :class => "Parking" do |p|
    p.coordinates "POINT(-100.3000 25.6667)"
    p.has_roof true
    p.kind Parking.category_for(:kinds, :government_provided)
    p.details "Detailed info"
  end
end