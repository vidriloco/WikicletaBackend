class Api::TipsController < Api::BaseController
  
  protect_from_forgery :except => [:update, :destroy, :create]
  
  before_filter :find_user_with_token, :only => [:create, :destroy, :update]
  before_filter :respond_to_bad_auth, :only => [:create, :destroy, :update]
  
  def create
    @tip = Tip.new_with(params[:tip], params[:coordinates], @user)

    if @tip.save
      render :json => { :success => true }, :status => :ok
    else
      render :json => { :errors => @tip.errors }, :status => 422
    end
  end
  
  def index
    @tips = Tip.find_nearby(params[:viewport])
    render :json => {:success => true, :tips => @tips.as_json}, :status => :ok
  end
  
  def update
    @tip = Tip.find(params[:id])
    
    if @tip.update_with(params[:tip], params[:coordinates], @user)
      render :json => { :success => true }, :status => :ok
    else
      render :json => { :errors => @tip.errors }, :status => 422
    end
  end
  
  def destroy    
    @tip = Tip.find(params[:id]) 
    
    if @tip.destroy
      render :nothing => true, :status => :ok
    else
      render :nothing => true, :status => 422
    end
  end
end