class ProfilesController < ApplicationController
  layout 'profiles'
  
  before_filter :find_user
  
  def index
    if @user.nil?
      redirect_to root_path
      return
    end

    #Refactor recent method to module of included models
    @items = (current_user.nil? || current_user != @user) ? Aggregator.all_activity_of(@user) : Aggregator.all_activity_on_wikicleta_as(current_user)
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