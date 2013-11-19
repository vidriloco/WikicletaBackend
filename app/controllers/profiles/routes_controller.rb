class Profiles::RoutesController < ProfilesController
  layout 'profiles'
  
  def index
    @routes = @user.owned_routes
  end
end