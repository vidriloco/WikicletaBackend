class Favorite < ActiveRecord::Base
  belongs_to :favorited_object, :polymorphic => true
  belongs_to :user
  
  validates :favorited_object, :user, :presence => true
  
  def self.mark(params)
    already_favorited = Favorite.where(params)
    if already_favorited.empty?
      Favorite.create(params)
    else
      already_favorited.first
    end
  end
  
  def self.unmark(params)
    already_favorited = Favorite.where(params)
    already_favorited.first.destroy unless already_favorited.empty?
  end
  
  def self.favorite?(params)
    !Favorite.where({:favorited_object_id => params[:favorited_object_id], :favorited_object_type => params[:favorited_object_type], :user_id => params[:user_id]}).empty?
  end
end
