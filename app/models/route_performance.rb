class RoutePerformance < ActiveRecord::Base
  include Api
  
  has_many :instants, :dependent => :destroy
  belongs_to :route
  belongs_to :user
  
  def as_json
    super({
      :only => [:id, :elapsed_time],
      :methods => [:str_created_at, :owner, :speed_average, :top_ten_instants]
    })
  end
  
  def speed_average
    average_speed.to_s
  end
  
  def top_ten_instants
    instants.order("speed DESC").limit(10).as_json
  end
end
