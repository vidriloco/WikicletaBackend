class Profiles::WorkshopsController < ProfilesController
  layout 'profiles'
  
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_workshop, :only => [:destroy, :edit, :update]
  
  def new
    @user = current_user
    @workshop = Workshop.new
  end
  
  def create
    @workshop = Workshop.new_with(params[:workshop], params[:coordinates], current_user)
    if @workshop.save
      redirect_to user_profile_path(current_user.username).concat("#/places/workshops/#{@workshop.identifier}")
    else
      render :action => :new
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    if @workshop.update_with(params[:workshop], params[:coordinates])
      redirect_to user_profile_path(@workshop.user.username).concat("#/places/workshops/#{@workshop.identifier}")
    else
      render :action => :edit
    end
  end
  
  def destroy
    @workshop.destroy
    redirect_to user_profile_path(current_user.username).concat('#/places')
  end
  
  private
  def find_workshop
    @workshop = Workshop.find(params[:id])
  end
end