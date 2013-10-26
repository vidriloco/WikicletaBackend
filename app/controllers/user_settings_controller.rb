class UserSettingsController < ApplicationController
  layout 'profiles'
  
  before_filter :authenticate_user!
  before_filter :expose_user
  
  before_filter :allow_superuser_to_edit
  
  def show
  end
  
  def update    
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
  
  def update_pic
    redirect_to(:back) && return unless params.has_key?(:file)
    Picture.find_or_create_from(params.merge(:user_id => @user.id))

    flash[:notice] = I18n.t("user_accounts.settings.successful_save")
    redirect_to :back
  end
  
  def destroy_pic
    @user.picture.destroy
    redirect_to :back
  end
  
  private 
  
  def expose_user
    @user = current_user
  end
  
  def allow_superuser_to_edit
    if params.has_key?(:username) && current_user.username != params[:username] && current_user.superuser?
      @user = User.where(:username => params[:username]).first
    else
      redirect_to :back
    end
  end
end
