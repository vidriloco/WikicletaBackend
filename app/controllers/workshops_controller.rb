class WorkshopsController < ApplicationController

  def index
    @workshops = []
    
    respond_to do |format|
      format.js do
        @workshops = Workshop.find_nearby(params[:viewport])
      end
    end
  end
  
end