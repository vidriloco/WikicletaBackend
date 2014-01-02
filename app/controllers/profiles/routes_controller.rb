class Profiles::RoutesController < ProfilesController
  layout 'on_map_center'

  before_filter :fetch_route
  before_filter :authenticate_allowed_users, :except => [:show]
  
  def show
  end
  
  def edit
    if @route.owned_by?(@user) || @user.superuser?
      render :layout => 'on_map_center'
    else
      redirect_to(:back)
    end
  end
  
  def update
    if @route.owned_by?(@user) || @user.superuser?
      if @route.update_with(params[:route], params[:path])
        message = {:notice => I18n.t('app.routes.notifications.updated.successfully') }
      else
        message = {:alert => I18n.t('app.routes.notifications.updated.unsuccessfully') }
      end

      redirect_to profiles_user_route_path(@route.first_owner.username, @route), message
    else
      redirect_to(:back)
    end
  end
  
  protected
  
  def authenticate_allowed_users
    @user = current_user
    if @user.nil?
      redirect_to root_path
    end
  end
  
  def fetch_route
    @route = Route.find(params[:id])
    
    if !@route.visible?(current_user)
      redirect_to(routes_path) and return
    end
  end
end