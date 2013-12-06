class Api::TipsController < Api::BaseController
  
  protect_from_forgery :except => [:update, :destroy, :create]
  
  before_filter :find_user_with_token, :only => [:create, :destroy, :update]
  before_filter :respond_to_bad_auth, :only => [:create, :destroy, :update]
  
  api :GET, '/tips', "Fetch the tips within a viewport defined by the constructing components of a bounding box (if given)"
  param :tips, Hash do
    param :sw, String, 'Coordinate pair defining south-west screen point'
    param :ne, String, 'Coordinate pair defining north-east screen point'
  end
  description <<-EOS
    == About the response
    The response for this request is an array of objects with the form:
        {"success":true,"tips":[{"category":2,"content":"Estos son atajos ciclistas muy buenos","dislikes_count":0,"id":52,"likes_count":0,"str_created_at":"2013-11-02 09:11:42","str_updated_at":"2013-11-02 09:12:29","lat":24.83281,"lon":-107.387276,"owner":{"username":"Punksolid","id":14}}]}
    Some details on the response attributes:
    * *pic* An attribute on the user object of the response which contains a URL of the user picture (An optional attribute)
    * *category* A numeric attribute which can take one of the following values: 1 for _danger_, 2 for _alert_ or 3 for _sightseeing_ . This values should be localized on the applications
  EOS
  def index
    @tips = Tip.find_nearby(params[:viewport])
    render :json => {:success => true, :tips => @tips.as_json}, :status => :ok
  end
  
  api :POST, '/tips', "Creates a new tip"
  param :extras, Hash, :required => true do
    param :auth_token, String, 'The _auth_token_ of the user received upon login on the application', :required => true
  end
  param :tip, Hash, :required => true do
    param :content, String, 'The contents or description for this tip', :required => true
    param :category, [1,2,3], 'The kind of tip this category is, which can take on the following values: 1 for _danger_, 2 for _alert_ or 3 for _sightseeing_', :required => true
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
    @tip = Tip.new_with(params[:tip], params[:coordinates], @user)

    if @tip.save
      render :json => { :success => true }, :status => :ok
    else
      render :json => { :errors => @tip.errors }, :status => 422
    end
  end
  
  api :PUT, '/tips/:id', "Updates an existent tip"
  param :id, Integer, 'This object id', :required => true
  param :extras, Hash, :required => true do
    param :auth_token, String, 'The _auth_token_ of the user received upon login on the application', :required => true
  end
  param :tip, Hash, :required => true do
    param :content, String, 'The contents or description for this tip', :required => true
    param :category, [1,2,3], 'The kind of tip this category is, which can take on the following values: 1 for _danger_, 2 for _alert_ or 3 for _sightseeing_', :required => true
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
    @tip = Tip.find(params[:id])
    
    if @tip.update_with(params[:tip], params[:coordinates], @user)
      render :json => { :success => true }, :status => :ok
    else
      render :json => { :errors => @tip.errors }, :status => 422
    end
  end
  
  api :POST, '/tips/:id', "Destroys an existent tip"
  param :extras, Hash, :required => true do
    param :auth_token, String, 'The _auth_token_ of the user received upon login on the application', :required => true
  end
  param :id, Integer, 'This object id', :required => true
  description <<-EOS
    == About the response
    The response for this API method is either a 
        success => true 
    response with status *200* or a
        errors => { some => errors } 
    hash with status *422*
  EOS
  def destroy    
    @tip = Tip.find(params[:id]) 
    
    if @tip.destroy
      render :nothing => true, :status => :ok
    else
      render :nothing => true, :status => 422
    end
  end
end
