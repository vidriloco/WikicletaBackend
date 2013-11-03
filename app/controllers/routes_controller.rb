class RoutesController < ApplicationController
  layout 'routes'
  
  before_filter :find_route, :only => [:show, :edit, :update, :destroy]
  before_filter :authenticate_allowed_users
  
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
  
  protected
  def find_route
    @route = Route.find(params[:id])
  end
  
  def authenticate_allowed_users
    @user = current_user
    if !@user.superuser?
      redirect_to root_path
    end
  end
end
