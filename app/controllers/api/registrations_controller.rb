class Api::RegistrationsController < Api::BaseController
    
  api :POST, '/users', "Creates a new user"
  
  param :registration, Hash, :required => true do
    param :name, String, "The user's name", :required => true
    param :username, String, "The user's username matching this regexp: ^[a-z0-9_-]{3,16}$", :required => true
    param :email, String, "The user's e-mail matching this regexp: [_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})", :required => true
    param :password, String, "The user's password", :required => true
    param :password_confirmation, String, "The user's password confirmation", :required => true
    param :image_pic, String, "Base64 encoded string for the user selected image picture"
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
    user = User.create_with(params[:registration])
    if user.persisted?
      render :json=> user.to_json, :status => :ok
    else
      warden.custom_failure!
      render :json=> {:errors => user.errors}, :status=>422
    end
  end
  
end

