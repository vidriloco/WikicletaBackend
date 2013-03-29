class Profiles::IncidentsController < ProfilesController
  layout 'profiles'
    
  def index
    @incidents = @user.incidents
    respond_to do |format|
      format.js
    end
  end
end