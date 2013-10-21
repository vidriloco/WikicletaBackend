class Api::RouteRankingsController < Api::BaseController
  
  protect_from_forgery :except => [:create]
  before_filter :find_user_with_token, :only => [:create]
  before_filter :respond_to_bad_auth, :only => [:create]
  
  def create
    @route_ranking = RouteRanking.new_or_find_with(params[:route_ranking], @user)
    
    if @route_ranking.save_or_update(params[:route_ranking])
      render :json => { :success => true }, :status => :ok
    else
      render :json => { :errors => @route_ranking.errors }, :status => 422
    end
  end
  
  def details
    @route_ranking = RouteRanking.where(:user_id => params[:user_id], :route_id => params[:route_id]).first
    render :json => { :success => true, :route_ranking => @route_ranking }, :status => :ok
  end
  
end