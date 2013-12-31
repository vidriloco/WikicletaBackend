require "spec_helper"

describe Api::ParkingsController do
  
  describe "API parkings controller" do

    it "matches /api/parkings? with controller :parkings action #index" do
      { :get => "/api/parkings" }.should route_to(:action => "index", :controller => "api/parkings")
    end
    
    it "matches /api/parkings with controller :parkings action #create" do
      { :post => 'api/parkings' }.should route_to(:action => "create", :controller => "api/parkings")
    end
    
    it "matches /api/parkings/:id with controller :parkings action #update" do
      { :put => 'api/parkings/1' }.should route_to(:action => "update", :controller => "api/parkings", :id => "1" )
    end
    
    it "matches /api/parkings/:id with controller :parkings action #delete" do
      { :post => 'api/parkings/1' }.should route_to(:action => "destroy", :controller => "api/parkings", :id => "1" )
    end
  end
end