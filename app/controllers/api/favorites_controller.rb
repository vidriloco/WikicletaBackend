class Api::FavoritesController < Api::BaseController
  
  protect_from_forgery :except => [:index, :mark, :unmark]
  before_filter :find_user_with_token, :only => [:mark, :unmark]
  before_filter :respond_to_bad_auth, :only => [:mark, :unmark]
  
  api :POST, '/api/favorites/mark', "Makes sure the object with the provided details gets marked as favorited"
  description <<-EOS
    == About the response
    The response for this request is always a success    
  EOS
  param :extras, Hash, :required => true do
    param :auth_token, String, 'The _auth_token_ of the user received upon login on the application', :required => true
  end
  param :favorite, Hash, :required => true do
    param :favorited_object_id, Integer, 'The id of the favorited object', :required => true
    param :favorited_object_type, String, 'The kind of the favorited object', :required => true
    param :user_id, Integer, "The id of the user who contributed the object"
  end
  def mark
    @favorite = Favorite.mark(params[:favorite])
    
    render :json => { :success => true }, :status => :ok
  end
  
  api :POST, '/api/favorites/unmark', "Makes sure the object with the provided details gets unmarked as favorited"
  description <<-EOS
    == About the response
    The response for this request is always a success    
  EOS
  param :extras, Hash, :required => true do
    param :auth_token, String, 'The _auth_token_ of the user received upon login on the application', :required => true
  end
  param :favorite, Hash, :required => true do
    param :favorited_object_id, Integer, 'The id of the favorited object', :required => true
    param :favorited_object_type, String, 'The kind of the favorited object', :required => true
    param :user_id, Integer, "The id of the user who contributed the object"
  end
  def unmark
    @favorite = Favorite.unmark(params[:favorite])
    
    render :json => { :success => true }, :status => :ok
  end
  
  api :GET, '/favorites/marked/:favorited_object_id/:favorited_object_type/:user_id', "Replies with true or false to the question of whether a POI is a favorite or not of someone"
  description <<-EOS
    == About the response
    The response for this request is a yes or no wrapped on a json formatted reponse similar to:
    {"success":true,"is_favorite":true}
    
    A :favorited_object_id and :user_id have both a numerical value, whilst a :favorited_object_type a string one such as "Parking" or "Tip"
  EOS
  def marked?
    @favorite = Favorite.favorite?(params)
    
    render :json => {:success => true, :is_favorite => @favorite }, :status => :ok
  end
  
  api :GET, '/favorites/list/:user_id', "Fetches the list of favorite items the user with the given user_id has"
  description <<-EOS
    == About the response
    The response for this request is an array of objects with the form:
        {"success":true,"favorites":{"Tip":[{"title":2,"description":"En el mercado de mixcalco los pasillos son amplios puedes entrar con la bici","lat":19.434502,"lon":-99.1254,"str_updated_at":"2013-10-29 16:17:11"}]}}
    The response within "favorites" contains, thus, a dictionary with the list of favorites grouped on categories: Tip, Parking, Workshop and so on. Inside each one, are the favorited elements on the category
  EOS
  def list
    @favorites = Favorite.all_from_user(params[:user_id])
    
    render :json => {:success => true, :favorites => @favorites }, :status => :ok
  end
end