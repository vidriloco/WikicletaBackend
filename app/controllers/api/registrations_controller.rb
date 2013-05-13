class Api::RegistrationsController < Api::BaseController
    
  def create
    user = User.new(params[:registration])
    if user.save
      render :json=> user.to_json, :status => :ok
    else
      warden.custom_failure!
      render :json=> {:errors => user.errors}, :status=>422
    end
  end
  
end

