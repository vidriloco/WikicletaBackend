# encoding: utf-8

FactoryGirl.define do
  factory :danger_tip, :class => "Tip" do |t|
    t.coordinates "POINT(-100.3000 25.6667)"
    t.content "Some silly tip"
    t.category Tip.category_for(:categories, :danger)
  end
end