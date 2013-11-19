class ProfilesController < ApplicationController
  layout 'profiles'
  
  before_filter :find_user
  
  def index
    if @user.nil?
      redirect_to root_path
      return
    end
    @activities = { :cycling_groups => @user.cycling_groups, :routes => @user.owned_routes }
  end
  
  private 
  
  def find_user
    @user = User.find_by_username(params[:username])
  end
end