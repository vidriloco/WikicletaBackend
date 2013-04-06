class Profiles::IncidentsController < ProfilesController
  layout 'profiles'
  
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :find_incident, :only => [:edit, :update, :destroy]
  
  def index
    @incidents = @user.incidents
    respond_to do |format|
      format.js
    end
  end
  
  def new
    @user = current_user
    @incident = Incident.new
  end
  
  def create
    @incident = Incident.new_with(params[:incident], params[:coordinates], current_user)
    if @incident.save
      redirect_to user_profile_path(current_user.username).concat("#/incidents/#{@incident.identifier}")
    else
      render :action => 'new'
    end  
  end
  
  def edit
    @user = current_user
  end
  
  def update
    if @incident.update_with(params[:incident], params[:coordinates], current_user)
      redirect_to user_profile_path(current_user.username).concat("#/incidents/#{@incident.identifier}")
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @incident.destroy
    redirect_to user_profile_path(current_user.username).concat('#/incidents')
  end
  
  private
  def find_incident
    @incident = Incident.find(params[:id])
  end
end