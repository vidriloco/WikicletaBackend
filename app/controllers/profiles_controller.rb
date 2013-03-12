class ProfilesController < ApplicationController
  layout 'profiles'
  
  before_filter :find
  
  def index
    if @user.nil?
      redirect_to root_path
      return
    end
  end
  
  def friends
    render(:template => 'profiles/not_found') && return if @user.nil?
  end
  
  def bikes
    @bikes = Bike.all_from_user(@user)
  end
  
  private 
  
  def find
    @user = User.find_by_username(params[:username])
  end
end