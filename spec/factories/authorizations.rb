# encoding: utf-8

FactoryGirl.define do
  factory :authorization do |a|
    a.secret    "lnc1YzW0ZAxnXddPJQcpuH9UFuKTuLHku3A2zWcVI"
    a.token     "68424522-JCr5mz0CtHOqX3MHMRbIGItUXAoVBFG4MVTK5oIQ"
    a.uid       "8584393"
    a.provider  "twitter"
  end
end