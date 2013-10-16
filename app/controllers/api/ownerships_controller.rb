class Api::OwnershipsController < Api::BaseController
  
  protect_from_forgery :except => [:list]
  
  def list
    @ownerships = Ownership.all_from_user(params[:user_id])
    
    render :json => {:success => true, :ownerships => @ownerships }, :status => :ok
  end
end