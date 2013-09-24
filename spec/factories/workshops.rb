# encoding: utf-8

FactoryGirl.define do
  factory :workshop_and_store, :class => "Workshop" do |w|
    w.coordinates "POINT(-100.3000 25.6667)"
    w.name "A test workshop"
    w.details "Detailed info"
    w.store true
    w.phone 59493933
  end
  
  factory :workshop_only, :class => "Workshop" do |w|
    w.coordinates "POINT(-100.3000 25.6667)"
    w.name "A test workshop"
    w.details "Detailed info"
    w.cell_phone 5556789878
    w.likes_count 4
  end
end