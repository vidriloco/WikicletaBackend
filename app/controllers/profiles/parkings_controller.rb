class Profiles::ParkingsController < ProfilesController
  layout 'profiles'
  
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_parking, :only => [:destroy, :edit, :update]
  
  def new
    @parking = Parking.new
  end
  
  def create
    @parking = Parking.new_with(params[:parking], params[:coordinates], current_user)
    
    if @parking.save
      redirect_to user_profile_path(current_user.username).concat("#/places/parkings/#{@parking.identifier}")
    else
      render :action => :new
    end
  end
  
  def edit
  end
  
  def update
    if @parking.update_with(params[:parking], params[:coordinates], current_user)
      redirect_to user_profile_path(current_user.username).concat("#/places/parkings/#{@parking.identifier}")
    else
      render :action => :edit
    end
  end
  
  def destroy
    @parking.destroy
    redirect_to user_profile_path(current_user.username).concat('#/places')
  end
    
  private
  def find_parking
    @parking = Parking.find(params[:id])
  end
end