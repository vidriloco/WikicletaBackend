class Api::RankedCommentsController < Api::BaseController
  
  protect_from_forgery :except => [:create]
  
  before_filter :find_user_with_token, :only => [:create]
  before_filter :respond_to_bad_auth, :only => [:create]

  def create
    @ranked_comment = RankedComment.new_with(params[:ranked_comment], @user)
    if @ranked_comment.save
      render :json => { :success => true }, :status => :ok
    else
      render :json => { :errors => @ranked_comment.errors }, :status => 422
    end
  end
end