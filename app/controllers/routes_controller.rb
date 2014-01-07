class RoutesController < ApplicationController
  layout 'on_map_center'
  
  before_filter :authenticate_user!, :only => [:destroy, :create, :new]
  before_filter :find_route, :only => [:destroy, :download]
  before_filter :authenticate_allowed_users, :only => [:destroy, :create, :new]
  
  def index
    @routes = []
    
    respond_to do |format|
      format.js do
        @routes = Route.find_nearby(params[:viewport])
      end
    end
  end
  
  def new
    @route = Route.new
  end
  
  def create
    @route = Route.new_with_path(params[:route], current_user, params[:path])
    if @route.save
      redirect_to user_profile_path(current_user.username), :notice => I18n.t('app.routes.notifications.created.successfully')
    else
      render :action => 'new', :alert => I18n.t('app.routes.notifications.created.unsuccessfully')
    end
  end
  
  def destroy
    if @route.owned_by?(@user) || @user.superuser?
      @route.destroy
      redirect_to user_profile_path(@user.username), :notice => I18n.t('app.routes.notifications.deleted.successfully')
    end
  end
  
  def download
    respond_to do |format|
      format.gpx { send_data @route.to_gpx(params[:performance_id]), :filename => @route.filename_for_performace(params[:performance_id]), :type => 'text/xm; charset=utf-8' }
    end
  end
  
  protected
  def find_route
    @route = Route.find(params[:id])
  end
  
  def authenticate_allowed_users
    @user = current_user
    if @user.nil?
      redirect_to root_path
    end
  end
end
