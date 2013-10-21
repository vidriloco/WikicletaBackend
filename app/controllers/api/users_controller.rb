class Api::UsersController < Api::BaseController
  
  def profile
    @user = User.find(params[:id])
    if @user
      render :json => {:success => true, :user => @user.profile_to_json}, :status => :ok
    else
      render :json => {:success=>false }, :status=>401
    end
  end
end