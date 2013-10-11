class Api::RoutesController < Api::BaseController
  
  protect_from_forgery :except => [:update, :destroy, :create]
  
  before_filter :find_user_with_token, :only => [:create, :destroy, :update]
  before_filter :respond_to_bad_auth, :only => [:create, :destroy, :update]

  def index
    @routes = Route.find_nearby(params[:viewport])
    render :json => {:success => true, :routes => @routes.as_json }, :status => :ok
  end

  def create
    @route = Route.new_with(params[:route], @user)
    if @route.save
      render :json => { :success => true }, :status => :ok
    else
      render :json => { :errors => @route.errors }, :status => 422
    end
  end
  
  def show
    @route = Route.find(params[:id])
    render :json => {:success => true, :route_path => @route.path_vector }
  end
  
end