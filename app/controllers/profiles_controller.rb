class ProfilesController < ApplicationController
  layout 'application'
  
  before_filter :find_user
  before_filter :authenticate_user!, :only => [:trails]
  before_filter :validate_user_can_view, :only => [:trails]
    
  def index
    if @user.nil?
      redirect_to root_path
      return
    end
    @activities = { :cycling_groups => @user.cycling_groups, :routes => @user.owned_routes.order('updated_at DESC'), :others => @user.cycle_paths }
  end
  
  def trails
    render :layout => 'on_map_center'
  end
  
  private 
  
  def find_user
    @user = User.find_by_username(params[:username])
  end
  
  def validate_user_can_view
    @user == current_user
  end

end