class Profiles::TipsController < ProfilesController
  layout 'profiles'
    
  def index
    @tips = @user.tips
    respond_to do |format|
      format.js
    end
  end
end