class ProfilesController < ApplicationController
  layout 'profiles'
  
  before_filter :find_user
  
  def index
    if @user.nil?
      redirect_to root_path
      return
    end
  end
  
  def activity
    @activities = { :cycling_groups => @user.cycling_groups }
  end
  
  def gear
    @bikes = Bike.all_from_user(@user)
  end
  
  private 
  
  def find_user
    @user = User.find_by_username(params[:username])
  end
end