class PromotedsController < ApplicationController
  def show
    @promoted = Promoted.find(params[:id])
  end
end
