require "spec_helper"

describe Api::FavoritesController do
  
  describe "API favorites controller" do

    it "matches /api/favorites/mark with controller :favorites action #mark" do
      { :post => "/api/favorites/mark" }.should route_to(:action => "mark", :controller => "api/favorites")
    end
    
    it "matches /api/favorites/unmark with controller :favorites action #unmark" do
      { :post => "/api/favorites/unmark" }.should route_to(:action => "unmark", :controller => "api/favorites")
    end
    
    it "matches /api/favorites/marked with controller :favorites action #marked?" do
      { :get => "/api/favorites/marked/1/2/3" }.should route_to(:action => "marked?", :controller => "api/favorites", :favorited_object_id => "1", :favorited_object_type => "2", :user_id => "3")
    end
  end
end