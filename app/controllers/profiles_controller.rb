class ProfilesController < ApplicationController  
  layout 'application'
  
  before_filter :find_user, :except => [:reset_tracking_code]
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
  
  def reset_tracking_code
    @user = User.find(params[:user_id])
    @user.update_tracking_number
    
    respond_to do |format|
      format.js
    end
  end
  
  private 
  
  def find_user
    @user = User.find_by_username(params[:username].downcase)
  end
  
  def validate_user_can_view
    @user == current_user
  end

end