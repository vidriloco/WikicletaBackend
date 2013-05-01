class Api::BaseController < ApplicationController
  
  skip_before_filter :verify_authenticity_token
  respond_to :json
  
  protected
  def find_user_with_token
    @user = User.where(:authentication_token => params[:extras][:auth_token]).first
  end
end
