class StatsController < ApplicationController
  layout 'on_map_center'
  
  def index
    @instants = Instant.find_nearby(params[:conditions])
    
    respond_to do |format|
      format.js
      format.html
    end
  end
end
