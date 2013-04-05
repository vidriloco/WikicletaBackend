class Profiles::TipsController < ProfilesController
  layout 'profiles'
  
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_tip, :only => [:destroy, :edit, :update]
  before_filter :find_user, :except => [:destroy]
  
  def index
    @tips = @user.tips
    respond_to do |format|
      format.js
    end
  end
  
  def new
    @tip = Tip.new
  end
  
  def create
    @tip = Tip.new_with(params[:tip], params[:coordinates], current_user)
    
    if @tip.save
      redirect_to user_profile_path(current_user.username).concat("#/tips/#{@tip.id}")
    else
      render :action => :new
    end
  end
  
  def edit
  end
  
  def update
    if @tip.update_with(params[:tip], params[:coordinates], current_user)
      redirect_to user_profile_path(current_user.username).concat('#/tips')
    else
      render :action => :edit
    end
  end
  
  def destroy
    @tip.destroy
    redirect_to user_profile_path(current_user.username).concat('#/tips')
  end
  
  private
  def find_user
    @user = current_user
  end
  
  def find_tip
    @tip = Tip.find(params[:id])
  end
end