# encoding: utf-8

FactoryGirl.define do
  
  factory :assault, :class => "Incident" do |i|
    i.kind Incident.kind_for(:assault)
    i.description "A crazy guy stole my bike with a knife"
    i.bike_description "A great blue bike"
    i.date_and_time Time.now
    i.complaint_issued true
    i.coordinates Point.from_lon_lat(-99.171610, 19.405704, 4326)
  end
  
  factory :theft, :class => "Incident" do |i|
    i.kind Incident.kind_for(:theft)
    i.description "Left my bike attached to a metal bar with a U-Lock and then the metal bar was broken and no bike!"
    i.bike_description "A great blue bike"
    i.date_and_time Time.now
    i.bike_item { Factory.build(:bike_item) }
    i.complaint_issued true
    i.coordinates Point.from_lon_lat(-99.131610, 19.305704, 4326)
  end
  
  factory :accident, :class => "Incident" do |i|
    i.kind Incident.kind_for(:accident)
    i.description "A car hit me slowly, my bike wheel is broken"
    i.vehicle_identifier "PO49392"
    i.date_and_time Time.now
    i.complaint_issued true
    i.coordinates Point.from_lon_lat(-99.181610, 19.205704, 4326)
  end
  
  factory :regulation_infraction, :class => "Incident" do |i|
    i.kind Incident.kind_for(:regulation_infraction)
    i.description "Someone stopped-by the cycle way"
    i.vehicle_identifier "PO49392"
    i.date_and_time Time.now
    i.complaint_issued true
    i.coordinates Point.from_lon_lat(-99.156610, 19.305704, 4326)
  end
  
end