# encoding: utf-8

FactoryGirl.define do
  factory :danger_tip, :class => "Tip" do
    coordinates "POINT(-99.13929848000407 19.38650804236533)"
    content "A dangerous point"
    category Tip.category_for(:categories, :danger)
  end
  
  factory :sightseeing_tip, :class => "Tip" do
    coordinates "POINT(-100.3000 22.10)"
    content "A place to visit on bicycle"
    category Tip.category_for(:categories, :sightseeing)
  end
  
  factory :alert_tip, :class => "Tip" do
    coordinates "POINT(-99.1385 19.3899999)"
    content "An alert someplace"
    category Tip.category_for(:categories, :alert)
  end
end