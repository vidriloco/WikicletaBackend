class Profiles::RoutesController < ProfilesController
  layout 'profiles'
  
  def index
    @routes = @user.owned_routes
  end
  
  def show
    @route = Route.find(params[:id])
  end
end