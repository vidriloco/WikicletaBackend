class Promoteds::LikesController < ApplicationController
    
  before_filter :authenticate_user!
    
  def create
    @promoted = Promoted.find(params[:id])
    @promoted.register_like_from(current_user)
    respond_with_changed_template
  end
  
  def destroy
    @promoted = Promoted.find(params[:id])
    @promoted.destroy_like_from(current_user)
    respond_with_changed_template
  end
  
  private
  def respond_with_changed_template
    respond_to do |format|
      format.js { render :template => 'promoteds/likes/change_count' }
    end
  end
end