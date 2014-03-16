class Api::TrackingController < Api::BaseController
  
  protect_from_forgery :except => [:show]
  
  def show
    @user = User.where(:tracking_number => params[:code]).first
    
    if @user.nil?
      render :json => { :success => false }, :status => :ok
    else
      render :json => { :success => true, :tracking => @user.last_tracking }, :status => :ok
    end
  end

end