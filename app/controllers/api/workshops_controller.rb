class Api::WorkshopsController < Api::BaseController
  
  protect_from_forgery :except => [:update, :destroy, :create]
  
  before_filter :find_user_with_token, :only => [:create, :destroy, :update]
  before_filter :respond_to_bad_auth, :only => [:create, :destroy, :update]
  
  api :GET, '/workshops', "Fetch the workshops within a viewport defined by the constructing components of a bounding box (if given)"
  param :workshop, Hash do
    param :sw, String, 'Coordinate pair defining south-west screen point'
    param :ne, String, 'Coordinate pair defining north-east screen point'
  end
  description <<-EOS
    == About the response
    The response for this request is an array of objects with the form:
        {"success":true,"workshops":[{"cell_phone":0,"details":"Es una tienda barata y algo grande","dislikes_count":0,"horary":"","id":63,"likes_count":0,"name":"Bicisport","phone":0,"store":true,"twitter":"","webpage":"","str_created_at":"2013-11-02 08:49:07","str_updated_at":"2013-11-02 08:50:48","lat":24.799633,"lon":-107.39529,"owner":{"username":"Punksolid","id":14,"kind":2, "pic":"/pics/users/199/images/292/mini_thumb_17de2191-c66a-486b-b23f-4a6442a1ad77.jpeg"}}]}
    Some details on the response attributes:
    * *pic* An attribute on the user object of the response which contains a URL of the user picture (An optional attribute)
  EOS
  def index
    @workshops = Workshop.find_nearby(params[:viewport])
    render :json => {:success => true, :workshops => @workshops.as_json}, :status => :ok
  end
  
  api :POST, '/workshops', "Creates a new workshop/store"
  param :extras, Hash, :required => true do
    param :auth_token, String, 'The _auth_token_ of the user received upon login on the application', :required => true
  end
  param :workshop, Hash, :required => true do
    param :name, String, 'A name for this workshop/store', :required => true
    param :details, String, 'Details for this workshop/store', :required => true
    param :store, [true, false], 'Whether this is also a store'
    param :phone, Integer, 'The phone number'
    param :cell_phone, Integer, 'The cellphone number'
    param :webpage, String, "It's webpage"
    param :twitter, String, "It's twitter handle without the '@'"
    param :horary, String, "It's horary"
    param :created_at, String, "Created at timestamp with format: yyyy-MM-dd'T'HH:mm:ss"
    param :updated_at, String, "Updated at timestamp with format: yyyy-MM-dd'T'HH:mm:ss"
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
    @workshop = Workshop.new_with(params[:workshop], params[:coordinates], @user)

    if @workshop.save
      render :json => { :success => true }, :status => :ok
    else
      render :json => { :errors => @workshop.errors }, :status => 422
    end
  end
  
  api :PUT, '/workshops/:id', "Updates an existent workshop/store"
  param :id, Integer, 'This object id', :required => true
  param :extras, Hash, :required => true do
    param :auth_token, String, 'The _auth_token_ of the user received upon login on the application', :required => true
  end
  param :workshop, Hash, :required => true do
    param :name, String, 'A name for this workshop/store', :required => true
    param :details, String, 'Details for this workshop/store', :required => true
    param :store, [true, false], 'Whether this is also a store'
    param :phone, Integer, 'The phone number'
    param :cell_phone, Integer, 'The cellphone number'
    param :webpage, String, "It's webpage"
    param :twitter, String, "It's twitter handle without the '@'"
    param :horary, String, "It's horary"
    param :updated_at, String, "Updated at timestamp with format: yyyy-MM-dd'T'HH:mm:ss"
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
  def update    
    @workshop = Workshop.find(params[:id])
    
    if @workshop.update_with(params[:workshop], params[:coordinates])
      render :json => { :success => true }, :status => :ok
    else
      render :json => { :errors => @workshop.errors }, :status => 422
    end
  end
  
  api :POST, '/workshops/:id', "Destroys the workshop/store with the provided id"
  param :extras, Hash, :required => true do
    param :auth_token, String, 'The _auth_token_ of the user received upon login on the application', :required => true
  end
  param :id, Integer, 'This object id', :required => true
  description <<-EOS
    == About the response
    The response for this API method contains a status value of 200 or 422
  EOS
  def destroy    
    @workshop = Workshop.find(params[:id]) 
    
    if @workshop.destroy
      render :nothing => true, :status => :ok
    else
      render :nothing => true, :status => 422
    end
  end
end