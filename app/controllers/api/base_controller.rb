class Api::BaseController < ApplicationController
  
  skip_before_filter :verify_authenticity_token
  respond_to :json
  
  protected
  def find_user_with_token
    @user = User.where(:authentication_token => params[:extras][:auth_token]).first
  end
  
  def respond_to_bad_auth
    if @user.nil?
      render :json => { :success => false, :message=>I18n.t('devise.failure.invalid_token') }, :status => 403
      return false
    end
  end
end
