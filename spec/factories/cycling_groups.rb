# encoding: utf-8

FactoryGirl.define do
  factory :bicitekas, :class => "CyclingGroup" do |w|
    w.coordinates "POINT(-100.3000 25.6667)"
    w.name "Bicitekas"
    w.details "Todos los miércoles, llueva, truene o se caiga el cielo, ellos saldrán a rodar"
    w.meeting_time "21:00"
    w.departing_time "21:30"
    w.periodicity CyclingGroup.build_timing_from_params({:day_timing => 3, :recurrence_timing => 2})
    w.twitter_account "bicitekas"
    w.website_url "http://someurl.com"
    w.facebook_url "http://facebook.com/someone"
  end
end