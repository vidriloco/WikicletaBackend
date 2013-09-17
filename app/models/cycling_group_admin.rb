class CyclingGroupAdmin < ActiveRecord::Base
  belongs_to :cycling_group
  belongs_to :user
end
