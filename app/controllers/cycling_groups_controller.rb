class CyclingGroupsController < ApplicationController
  layout 'discover'
  
  before_filter :authenticate_user!, :except => [:index]
  before_filter :set_user
  before_filter :find_cycling_group, :only => [:edit, :update, :destroy]
  
  def index
    @cycling_groups = []
    
    respond_to do |format|
      format.js { @cycling_groups = CyclingGroup.find_nearby_with(params[:viewport], params[:extra]).sort_by(&:number_of_days_to_event) }
      format.html { @city = City.find(cookies[:city_id]) unless cookies[:city_id].nil? }
    end
  end
  
  def new
    @cycling_group = CyclingGroup.new
  end
  
  def create
    @cycling_group = CyclingGroup.new_with(params[:cycling_group], params[:coordinates])
    if @cycling_group.save
      @cycling_group.set_logo_and_user(params[:picture], @user)
      redirect_to discover_cycling_groups_path, :notice => I18n.t("cycling_groups.views.created.success") 
    else
      render :action => :new
    end
  end
  
  def edit
    # Only the cycling group registered admins can edit it
    unless @user.admins_cycling_group?(@cycling_group)
      redirect_to discover_cycling_groups_path.concat("#/#{@cycling_group.slug}")
    end
  end
  
  def update
    if @cycling_group.update_with(params, current_user)
      redirect_to discover_cycling_groups_path.concat('#/'+@cycling_group.slug)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @cycling_group.destroy if @user.admins_cycling_group?(@cycling_group)
    redirect_to :back
  end
  
  private
  def set_user
    @user ||= current_user
  end
  
  def find_cycling_group
    @cycling_group = CyclingGroup.where(:slug => params[:id]).first
  end
end