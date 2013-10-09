class RoutePerformance < ActiveRecord::Base
  has_many :instants, :dependent => :destroy
  belongs_to :route
  belongs_to :user
end
