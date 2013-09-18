class SettingsController < ApplicationController
  layout 'profiles'
  
  before_filter :authenticate_user!
  before_filter :expose_user
  
  def profile
  end
  
  def access
  end
  
  def changed    
    params_hash = params[:user]
    params_hash.merge!(:current_password => params[:current_password]) if params.has_key?(:current_password)
    
    if @user.check_parameters_and_password(params_hash) && @user.update_attributes(params_hash)
      sign_in(@user, :bypass => true)
      flash[:notice] = I18n.t("user_accounts.settings.successful_save")
    else
      flash[:alert] = I18n.t("user_accounts.settings.unsuccessful_save")
    end
    
    redirect_to request.referer || 'profile'    
  end
  
  def change_picture
    redirect_to(:back) && return unless params.has_key?(:file)
    Picture.find_or_create_from(params.merge(:user_id => current_user.id))

    flash[:notice] = I18n.t("user_accounts.settings.successful_save")
    redirect_to :back
  end
  
  def destroy_picture
    current_user.picture.destroy
    redirect_to :back
  end
  
  private 
  
  def expose_user
    @user = current_user
  end
end
