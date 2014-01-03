class CyclePathsController < ApplicationController
  layout 'on_map_center'
  
  before_filter :find_cycle_path, :only => [:destroy, :edit, :update]
  before_filter :authenticate_allowed_users, :except => [:index]
  
  def index
    @cycle_paths = []
    
    respond_to do |format|
      format.js do
        @cycle_paths = CyclePath.find_nearby(params[:viewport])
      end
    end
  end
  
  def new
    @cycle_path = CyclePath.new
  end
  
  def edit
    if @cycle_path.owned_by?(@user) || @user.can_contribute_to_city?
      render :layout => 'on_map_center'
    else
      redirect_to(:back)
    end
  end
  
  def update
    if @cycle_path.owned_by?(@user) || @user.can_contribute_to_city?
      if @cycle_path.update_with(params[:cycle_path], params[:path])
        message = {:notice => I18n.t('app.cycle_paths.notifications.updated.successfully') }
      else
        message = {:alert => I18n.t('app.cycle_paths.notifications.updated.unsuccessfully') }
      end

      redirect_to user_profile_path(@cycle_path.users.first.username), message
    else
      redirect_to(:back)
    end
  end
  
  def create
    @cycle_path = CyclePath.new_with_path(params[:cycle_path], current_user, params[:path])
    if @cycle_path.save
      redirect_to user_profile_path(@user.username), :notice => I18n.t('app.cycle_paths.notifications.created.successfully')
    else
      render :action => 'new', :alert => I18n.t('app.cycle_paths.notifications.created.unsuccessfully')
    end
  end
  
  def destroy
    if @cycle_path.owned_by?(@user) || @user.can_contribute_to_city?
      @cycle_path.destroy
      redirect_to user_profile_path(@user.username), :notice => I18n.t('app.cycle_paths.notifications.deleted.successfully')
    end
  end

  protected
  def find_cycle_path
    @cycle_path = CyclePath.find(params[:id])
  end
  
  def authenticate_allowed_users
    @user = current_user
    if @user.nil?
      redirect_to root_path
    end
  end
end
