class Api::ParkingsController < Api::BaseController
  
  protect_from_forgery :except => [:update, :destroy, :create]
  before_filter :find_user_with_token, :only => [:create, :destroy, :update]
  before_filter :respond_to_bad_auth, :only => [:create, :destroy, :update]
  
  api :POST, '/parkings', "Creates a new parking"
  param :extras, Hash, :required => true do
    param :auth_token, String, 'The _auth_token_ of the user received upon login on the application', :required => true
  end
  param :parking, Hash, :required => true do
    param :details, String, 'The details for this parking', :required => true
    param :kind, [1,2,3], 'The kind of parking, which can take on the following values: 1 for _government_provided_, 2 for _urban_mobiliary_ or 3 for _venue_provided_', :required => true
    param :created_at, String, "Created at timestamp with format: yyyy-MM-dd'T'HH:mm:ss"
    param :updated_at, String, "Updated at timestamp with format: yyyy-MM-dd'T'HH:mm:ss"
    param :has_roof, TrueClass, "Whether this parking place has a roof or not"
  end
  param :coordinates, Hash, :required => true do 
    param :lat, Float, 'Latitude component', :required => true
    param :lon, Float, 'Longitude component', :required => true
  end
  description <<-EOS
    == About the response
    The response for this API method is either a 
        success => true 
    response with status *200* or a
        errors => { some => errors } 
    hash with status *422*
  EOS
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