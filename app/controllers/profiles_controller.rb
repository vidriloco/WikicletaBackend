class ProfilesController < ApplicationController
  layout 'profiles'
  
  before_filter :find_user
  
  def index
    if @user.nil?
      redirect_to root_path
      return
    end
  end
  
  def bikes
    @bikes = Bike.all_from_user(@user)
  end
  
  private 
  
  def find_user
    @user = current_user || User.find_by_username(params[:username])
  end
end