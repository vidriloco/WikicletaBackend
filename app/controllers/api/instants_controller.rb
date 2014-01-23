class Api::InstantsController < Api::BaseController
  protect_from_forgery :except => [:create]
  
  before_filter :find_user_with_token, :only => [:create]
  before_filter :respond_to_bad_auth, :only => [:create]
  
  def create
    @instants = Instant.bulk_create(params[:instants], @user)
    if @instants.count > 0
      render :json => {:success => true}, :status => :ok
    else
      render :json => {:success => false}, :status => 422
    end
  end

end