class Api::FavoritesController < Api::BaseController
  
  protect_from_forgery :except => [:index, :mark, :unmark]
  before_filter :find_user_with_token, :only => [:mark, :unmark]
  before_filter :respond_to_bad_auth, :only => [:mark, :unmark]
  
  def mark
    @favorite = Favorite.mark(params[:favorite])
    
    render :json => { :success => true }, :status => :ok
  end
  
  def unmark
    @favorite = Favorite.unmark(params[:favorite])
    
    render :json => { :success => true }, :status => :ok
  end
  
  def marked?
    @favorite = Favorite.favorite?(params)
    
    render :json => {:success => true, :is_favorite => @favorite }, :status => :ok
  end
  
  def list
    @favorites = Favorite.all_from_user(params[:user_id])
    
    render :json => {:success => true, :favorites => @favorites }, :status => :ok
  end
end