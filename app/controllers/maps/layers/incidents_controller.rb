class Maps::Layers::IncidentsController < Maps::RootController
  
  before_filter :find_incident, :only => [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:index, :show]
  
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
  
  def update
    if @incident.update_with(params[:incident], params[:coordinates], current_user)
      redirect_to maps_layers_incidents_path
    else
      render :action => 'ed', :layout => 'maps_extended'
    end
  end
  
  def index
    @incidents_count = Incident.categorized_by_kinds
    @incidents = Incident.all
  end
  
  def destroy
    @incident.destroy
    
    respond_to do |format|
      format.js
    end
  end
  
  def edit
    render :layout => 'maps_extended'
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