class Api::SessionsController < Api::BaseController
  before_filter :ensure_params_exist
 
  api :POST, '/users/sign_in', "Creates a session for a user and stores it's authentication token"
  
  param :session, Hash, :required => true do
    param :login, String, "The user's email or the user's username can be used to login", :required => true
    param :password, String, "The user's password", :required => true
  end
  
  description <<-EOS
    == About the response
    The response for this API method is either a 
        { auth_token => "REGISTRATION TOKEN", full_name => "Full name", username => "username", email => "user@mail.com", bio => "A bio" }
    response with status *200* or a
        { errors => { some => errors } } 
    hash with status *422*
  EOS
  def create
    resource = User.find_for_database_authentication(:login=>params[:session][:login])
    return invalid_login_attempt unless resource
 
    if resource.valid_password?(params[:session][:password])
      sign_in("user", resource)
      render :json=> resource.to_json, :status => :ok
      return
    end
    invalid_login_attempt
  end
  
  def destroy
    resource = User.find_for_database_authentication(:login=>params[:session][:login])
    sign_out(resource)
  end
 
  protected
  def ensure_params_exist
    return unless params[:session].blank?
    render :json=>{:success=>false, :message=>"missing session parameter"}, :status=>422
  end
 
  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=> I18n.t('devise.failure.invalid') }, :status=>401
  end
end