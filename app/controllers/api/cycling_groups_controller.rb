class Api::CyclingGroupsController < Api::BaseController
  
  def index
    @cycling_groups = CyclingGroup.find_nearby_with(params[:viewport], params[:extras] || {})
    render :json => {:success => true, :cycling_groups => @cycling_groups.as_json}, :status => :ok
  end
end