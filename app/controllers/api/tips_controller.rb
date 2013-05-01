class Api::TipsController < Api::BaseController
  
  protect_from_forgery :except => [:update, :delete, :create]
  before_filter :find_user_with_token, :only => [:create]
  
  def create
    
    if @user.nil?
      render :json => { :success => false, :message=>I18n.t('devise.failure.invalid_token') }, :status => 422
    else
      @tip = Tip.new_with(params[:tip], params[:tip].delete(:coordinates), @user)

      if @tip.save
        render :json => { :success => true }, :status => :ok
      else
        render :json => { :errors => @tip.errors }, :status => 422
      end
    end
  end
  
  def index
    @tips = Tip.find_nearby(params[:viewport])
    render :json => {:success => true, :tips => @tips.as_json}, :status => :ok
  end
end