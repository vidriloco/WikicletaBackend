class Api::WorkshopsController < Api::BaseController
  
  protect_from_forgery :except => [:update, :destroy, :create]
  
  before_filter :find_user_with_token, :only => [:create, :destroy, :update]
  before_filter :respond_to_bad_auth, :only => [:create, :destroy, :update]
  
  def index
    @workshops = Workshop.find_nearby(params[:viewport])
    render :json => {:success => true, :workshops => @workshops.as_json}, :status => :ok
  end
  
  def create
    @workshop = Workshop.new_with(params[:workshop], params[:coordinates], @user)

    if @workshop.save
      render :json => { :success => true }, :status => :ok
    else
      render :json => { :errors => @workshop.errors }, :status => 422
    end
  end
  
  def update    
    @workshop = Workshop.find(params[:id])
    
    if @workshop.update_with(params[:workshop], params[:coordinates])
      render :json => { :success => true }, :status => :ok
    else
      render :json => { :errors => @workshop.errors }, :status => 422
    end
  end
  
  def destroy    
    @workshop = Workshop.find(params[:id]) 
    
    if @workshop.destroy
      render :nothing => true, :status => :ok
    else
      render :nothing => true, :status => 422
    end
  end
end