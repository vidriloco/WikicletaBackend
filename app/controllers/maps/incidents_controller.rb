class Maps::IncidentsController < MapsController
    
  def index
    @incidents_count = Incident.categorized_by_kinds
    @incidents = Incident.all
  end
  
end