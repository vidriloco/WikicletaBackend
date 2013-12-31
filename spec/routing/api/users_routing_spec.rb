require "spec_helper"

describe Api::UsersController do
  
  describe "API users controller" do

    it "matches /api/profiles/:id with controller :users action #profile" do
      { :get => "/api/profiles/1" }.should route_to(:action => "profile", :controller => "api/users", :id => "1")
    end
    
    it "matches /api/profiles/:id with controller :users action #update" do
      { :post => '/api/profiles/1' }.should route_to(:action => "update", :controller => "api/users", :id => "1")
    end
  end
end