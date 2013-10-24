class Api::RegistrationsController < Api::BaseController
    
  def create
    user = User.create_with(params[:registration])
    if user.persisted?
      render :json=> user.to_json, :status => :ok
    else
      warden.custom_failure!
      render :json=> {:errors => user.errors}, :status=>422
    end
  end
  
end

