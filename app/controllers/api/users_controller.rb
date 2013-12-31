class Api::UsersController < Api::BaseController
  
  protect_from_forgery :except => [:update]
  
  before_filter :find_user_with_token, :only => [:update]
  before_filter :respond_to_bad_auth, :only => [:update]
  
  api :GET, '/api/profiles/:id', "Fetches a user profile data in json format"
  
  param :id, Integer, "The user's id"
  description <<-EOS
    == About the response
    The response for this API method has the following form: 
        {"success":true,"user":{"city_name":null,"user_pic": <URL or empty> ,"username":"syracuse","bio":null,"updated_at":"2013-05-19 21:02:46","identifier":"12","email":"syracuse13alex@hotmail.com"}}
  EOS
  def profile
    @user = User.find(params[:id])
    if @user
      render :json => {:success => true, :user => @user.profile_to_json}, :status => :ok
    else
      render :json => {:success=>false }, :status=>401
    end
  end
  
  api :POST, '/api/profiles/:id', "Updates a user profile"
  param :id, Integer, "The user's id"
  param :extras, Hash, :required => true do
    param :auth_token, String, "The user's auth token"
  end
  param :user, Hash, :required => true do
    param :image_pic, String, "A Base64 representation of an image"
    param :username, String, "The user's username"
    param :bio, String, "The user's bio"
    
  end
  description <<-EOS
    == About the response
    The response for this API method has the following form if successfull
        {"success":true,"user":{"city_name":null,"user_pic": <URL or empty> ,"username":"syracuse","bio":null,"updated_at":"2013-05-19 21:02:46","identifier":"12","email":"syracuse13alex@hotmail.com"}}
    Else
        {"success":false }
  EOS
  def update
    if @user && @user.update_with(params[:user])
      render :json => {:success => true, :user => @user.profile_to_json}, :status => :ok
    else
      render :json => {:success=>false }, :status=>401
    end
  end
end