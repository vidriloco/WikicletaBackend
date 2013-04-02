class Maps::TipsController < MapsController

  def index
    @tips_count = Tip.categorized_by_kinds
    @tips = Tip.all
  end
  
end