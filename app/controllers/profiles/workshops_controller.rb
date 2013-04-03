class Profiles::WorkshopsController < ProfilesController
  layout 'profiles'
  
  def new
    @user = current_user
    @workshop = Workshop.new
  end
  
end