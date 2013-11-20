class Profiles::RoutesController < ProfilesController
  layout 'profiles'

  before_filter :fetch_route, :except => [:index]
  
  def index
    @routes = @user.owned_routes
  end
  
  def show
  end
  
  def edit
    render :layout => 'routes'
  end
  
  def update
    if @route.update_with(params[:route], params[:path])
      message = {:notice => I18n.t('app.routes.notifications.updated.successfully') }
    else
      message = {:alert => I18n.t('app.routes.notifications.updated.unsuccessfully') }
    end
    
    redirect_to profiles_user_route_path(@route.first_owner.username, @route), message
  end
  
  def destroy
    @route.destroy
    redirect_to profiles_path(@route.first_owner.username)
  end
  
  protected
  
  def fetch_route
    @route = Route.find(params[:id])
    
    if !@route.visible?(current_user)
      redirect_to(routes_path) and return
    end
  end
end