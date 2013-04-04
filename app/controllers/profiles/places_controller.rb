class Profiles::PlacesController < ProfilesController
  layout 'profiles'
  
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def index
    @places = { :workshops => Workshop.all }
    respond_to do |format|
      format.js
    end
  end
  
end