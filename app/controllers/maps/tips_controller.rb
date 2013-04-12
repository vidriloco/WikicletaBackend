class Maps::TipsController < MapsController

  def index
    @tips_count = Tip.categorized_by_kinds(params[:viewport])
    @tips = Tip.find_nearby(params[:viewport])

    respond_to do |format|
      format.js
      format.html
    end
  end
  
end