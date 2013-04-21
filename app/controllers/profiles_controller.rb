class ProfilesController < ApplicationController
  layout 'profiles'
  
  before_filter :find_user
  
  def index
    if @user.nil?
      redirect_to root_path
      return
    end
    
    #Refactor recent method to module of included models
    @items = (
      Workshop.recent(current_user)+
      Parking.recent(current_user)+
      Incident.recent(current_user)+
      Bike.recent(current_user)+
      Tip.recent(current_user)).sort_by(&:updated_at).reverse!
  end
  
  def gear
    @bikes = Bike.all_from_user(@user)
  end
  
  private 
  
  def find_user
    @user = User.find_by_username(params[:username])
  end
end