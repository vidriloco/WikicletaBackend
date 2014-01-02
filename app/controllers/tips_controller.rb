class TipsController < ApplicationController

  def index
    @tips = []
    
    respond_to do |format|
      format.js do
        @tips = Tip.find_nearby(params[:viewport])
      end
    end
  end
  
end