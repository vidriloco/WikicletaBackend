class Maps::Layers::IncidentsController < Maps::RootController
  
  before_filter :find_incident, :only => [:show]
    
  def new
    @incident = Incident.new
    render :layout => 'maps_extended'
  end  
  
  def create
    @incident = Incident.new_with(params[:incident], params[:coordinates], current_user)
    if @incident.save
      redirect_to maps_layers_incidents_path
    else
      render :action => 'new', :layout => 'maps_extended'
    end  
  end
  
  def index
    respond_to do |format|
      format.js { @incidents = Incident.categorized_by_kinds }
      format.html { @incident = Incident.new }
    end
  end
  
  def destroy
    @incident = Incident.find(params[:id])
    @incident.destroy
    
    respond_to do |format|
      format.js
    end
  end
  
  def show
    respond_to do |format|
      format.js
    end
  end
  
  def filtering
    @incidents = Incident.filtering_with(params[:incident])
    @filtering = true
    render :action => 'index'
  end
  
  private
  def find_incident
    @incident = Incident.find(params[:id])
  end
end