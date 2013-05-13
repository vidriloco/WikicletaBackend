class Api::TipsController < Api::BaseController
  
  protect_from_forgery :except => [:update, :destroy, :create]
  before_filter :find_user_with_token, :only => [:create, :destroy, :update]
  
  def create
    if @user.nil?
      render :json => { :success => false, :message=>I18n.t('devise.failure.invalid_token') }, :status => 422
    else
      @tip = Tip.new_with(params[:tip], params[:tip].delete(:coordinates), @user)

      if @tip.save
        render :json => { :success => true }, :status => :ok
      else
        render :json => { :errors => @tip.errors }, :status => 422
      end
    end
  end
  
  def index
    @tips = Tip.find_nearby(params[:viewport])
    render :json => {:success => true, :tips => @tips.as_json}, :status => :ok
  end
  
  def update
    render :status => 403 && return if @user.nil?
    
    @tip = Tip.find(params[:id])
    
    if @tip.update_with(params[:tip], params[:tip].delete(:coordinates), @user)
      render :json => { :success => true }, :status => :ok
    else
      render :json => { :errors => @tip.errors }, :status => 422
    end
  end
  
  def destroy
    render :status => 403 && return if @user.nil?
    
    @tip = Tip.find(params[:id]) 
    
    if @tip.destroy
      render :nothing => true, :status => :ok
    else
      render :nothing => true, :status => 422
    end
  end
end