class Maps::IncidentsController < MapsController
    
  def index
    @incidents_count = Incident.categorized_by_kinds(params[:viewport])
    @incidents = Incident.find_nearby(params[:viewport])
    
    respond_to do |format|
      format.js
      format.html
    end
  end
  
end