class CyclingGroupsController < ApplicationController
  layout 'discover'
  
  def index
    @cycling_groups = CyclingGroup.those_riding_near(:today, params[:viewport])
    @city = City.first
  end
end
