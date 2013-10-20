class Api::RankedCommentsController < Api::BaseController
  
  protect_from_forgery :except => [:create, :destroy]
  
  before_filter :find_user_with_token, :only => [:create, :destroy]
  before_filter :respond_to_bad_auth, :only => [:create, :destroy]

  def create
    @ranked_comment = RankedComment.new_with(params[:ranked_comment], @user)
    if @ranked_comment.save
      render :json => { :success => true }, :status => :ok
    else
      render :json => { :errors => @ranked_comment.errors }, :status => 422
    end
  end
  
  def list
    @ranked_comments = RankedComment.list(params)
    render :json => { :success => true, :ranked_comments => @ranked_comments }, :status => :ok
  end
  
  def destroy
    @ranked_comment = RankedComment.find(params[:id])
    if @ranked_comment.destroy
      render :json => { :success => true }, :status => :ok
    else
      render :json => { :errors => @ranked_comment.errors }, :status => 422
    end
  end
end