class Api::WorkshopsController < Api::BaseController
  
  protect_from_forgery :except => [:update, :destroy, :create]
  before_filter :find_user_with_token, :only => [:create, :destroy, :update]
  
  def create
    if @user.nil?
      render :json => { :success => false, :message=>I18n.t('devise.failure.invalid_token') }, :status => 422
    else
      @workshop = Workshop.new_with(params[:workshop], params[:workshop].delete(:coordinates), @user)

      if @workshop.save
        render :json => { :success => true }, :status => :ok
      else
        render :json => { :errors => @workshop.errors }, :status => 422
      end
    end
  end
  
  def index
    @workshops = Workshop.find_nearby(params[:viewport])
    render :json => {:success => true, :workshops => @workshops.as_json}, :status => :ok
  end
  
  def update
    render :status => 403 && return if @user.nil?
    
    @workshop = Workshop.find(params[:id])
    
    if @workshop.update_with(params[:workshop], params[:workshop].delete(:coordinates))
      render :json => { :success => true }, :status => :ok
    else
      render :json => { :errors => @workshop.errors }, :status => 422
    end
  end
  
  def destroy
    render :status => 403 && return if @user.nil?
    
    @workshop = Workshop.find(params[:id]) 
    
    if @workshop.destroy
      render :nothing => true, :status => :ok
    else
      render :nothing => true, :status => 422
    end
  end
end