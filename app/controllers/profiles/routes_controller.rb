class Profiles::RoutesController < ProfilesController
  layout 'profiles'
    
  def index
    @routes = @user.owned_routes
  end
  
  def show
    @route = Route.find(params[:id])
    if !@route.visible?(current_user)
      redirect_to(routes_path) and return
    end
  end
end