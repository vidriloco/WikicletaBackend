require "spec_helper"

describe Api::RoutesController do
  
  describe "API routes controller" do

    it "matches /api/routes with controller :routes action #create" do
      { :post => "/api/routes" }.should route_to(:action => "create", :controller => "api/routes")
    end
    
    it "matches /api/routes with controller :routes action #index" do
      { :get => "/api/routes" }.should route_to(:action => "index", :controller => "api/routes")
    end
    
  end
end