require "spec_helper"

describe Api::RoutesController do
  
  describe "API routes controller" do

    it "matches /api/routes with controller :routes action #create" do
      { :post => "/api/routes" }.should route_to(:action => "create", :controller => "api/routes")
    end
    
    it "matches /api/routes with controller :routes action #index" do
      { :get => "/api/routes" }.should route_to(:action => "index", :controller => "api/routes")
    end
    
    it "matches /api/routes/1 with controller :routes action #show" do
      { :get => "/api/routes/1" }.should route_to(:action => "show", :controller => "api/routes", :id => "1")
    end
    
    it "matches /api/routes/1 with controller :routes action #show" do
      { :post => "/api/routes/1" }.should route_to(:action => "destroy", :controller => "api/routes", :id => "1")
    end
    
  end
end