class Api::UsersController < Api::BaseController
  
  protect_from_forgery :except => [:update]
  
  before_filter :find_user_with_token, :only => [:update]
  before_filter :respond_to_bad_auth, :only => [:update]

  def profile
    @user = User.find(params[:id])
    if @user
      render :json => {:success => true, :user => @user.profile_to_json}, :status => :ok
    else
      render :json => {:success=>false }, :status=>401
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_with(params[:user])
      render :json => {:success => true, :user => @user.profile_to_json}, :status => :ok
    else
      render :json => {:success=>false }, :status=>401
    end
  end
end