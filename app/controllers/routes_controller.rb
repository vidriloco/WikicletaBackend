class RoutesController < ApplicationController
  layout 'routes'
  
  before_filter :find_route, :only => [:show, :edit, :update, :destroy, :download]
  before_filter :authenticate_allowed_users, :except => [:download]
  
  def index
    @routes = Route.all
  end
  
  def show
  end
  
  def edit
    
  end
  
  def update
    if @route.update_with(params[:route], params[:path])
      redirect_to route_path(@route)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @route.destroy
    redirect_to routes_path
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
    if @user.nil? || !@user.superuser?
      redirect_to root_path
    end
  end
end
