class BikesController < ApplicationController
  layout 'extended'
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :mine] 
  before_filter :find_bike, :only => [:edit, :update, :show, :destroy]
  
  def index
    @bikes = Bike.order('created_at DESC')
  end
  
  def stolen
    @bikes = Bike.fetch_stolen(current_user)
    render :action => 'index'
  end
  
  def recovered
    @bikes = Bike.fetch_stolen(current_user, :include_recovered_ones_only)
    render :action => 'index'
  end
  
  def popular
    @bikes = Bike.most_popular(current_user)
    render :action => 'index'
  end
  
  def sell_or_rent
    @bikes = Bike.for_social_use([:rent, :sell], current_user)
    render :action => 'index'
  end
  
  def shared
    @bikes = Bike.for_social_use([:share], current_user)
    render :action => 'index'
  end
  
  def new
    @bike = Bike.new
  end
  
  def create
    @bike = Bike.new_with_owner(params[:bike], current_user)
    if @bike.save
      redirect_to @bike, :notice => I18n.t('bikes.messages.saved')
    else
      render :action => 'new'
    end
  end
  
  def edit 
  end
  
  def update
    if @bike.update_attributes_with_owner(params[:bike], current_user)
      redirect_to @bike, :notice => I18n.t('bikes.messages.updated')
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @bike.destroy
    redirect_to bikes_path, :notice => I18n.t('bikes.messages.deleted')
  end

  def show
    respond_to do |format|
      format.js
      format.html do
        @statuses = BikeStatus.find_all_for_bike(params[:id])
      end
    end
  end

  private
  def find_bike
    @bike = Bike.find(params[:id])
  end
  
end