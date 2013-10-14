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
      { :get => "/api/favorites/marked/1/1/1" }.should route_to(:action => "marked?", :controller => "api/favorites", :object_id => "1", :object_type => "1", :user_id => "1")
    end
  end
end