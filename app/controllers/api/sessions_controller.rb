class Api::SessionsController < Api::BaseController
  before_filter :ensure_params_exist
 
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