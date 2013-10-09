class Api::RoutesController < Api::BaseController
  
  protect_from_forgery :except => [:update, :destroy, :create]
  
  before_filter :find_user_with_token, :only => [:create, :destroy, :update]
  before_filter :respond_to_bad_auth, :only => [:create, :destroy, :update]

  def create
    @route = Route.new_with(params[:route], @user)
    if @route.save
      render :json => { :success => true }, :status => :ok
    else
      render :json => { :errors => @route.errors }, :status => 422
    end
  end
  
end