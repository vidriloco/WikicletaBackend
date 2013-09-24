class Api::ParkingsController < Api::BaseController
  
  protect_from_forgery :except => [:update, :destroy, :create]
  before_filter :find_user_with_token, :only => [:create, :destroy, :update]
  before_filter :respond_to_bad_auth, :only => [:create, :destroy, :update]
  
  def create
    @parking = Parking.new_with(params[:parking], params[:coordinates], @user)

    if @parking.save
      render :json => { :success => true }, :status => :ok
    else
      render :json => { :errors => @parking.errors }, :status => 422
    end
  end
  
  def index
    @parkings = Parking.find_nearby(params[:viewport])
    render :json => {:success => true, :parkings => @parkings.as_json}, :status => :ok
  end
  
  def update    
    @parking = Parking.find(params[:id])
    
    if @parking.update_with(params[:parking], params[:coordinates])
      render :json => { :success => true }, :status => :ok
    else
      render :json => { :errors => @parking.errors }, :status => 422
    end
  end
  
  def destroy
    @parking = Parking.find(params[:id]) 
    
    if @parking.destroy
      render :nothing => true, :status => :ok
    else
      render :nothing => true, :status => 422
    end
  end
end