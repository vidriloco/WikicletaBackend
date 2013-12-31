require "spec_helper"

describe Api::TipsController do
  
  describe "API tips controller" do

    it "matches /api/tips? with controller :tips action #index" do
      { :get => "/api/tips" }.should route_to(:action => "index", :controller => "api/tips")
    end
    
    it "matches /api/tips with controller :tips action #create" do
      { :post => 'api/tips' }.should route_to(:action => "create", :controller => "api/tips")
    end
    
    it "matches /api/tips/:id with controller :tips action #update" do
      { :put => 'api/tips/1' }.should route_to(:action => "update", :controller => "api/tips", :id => "1" )
    end
    
    it "matches /api/tips/:id with controller :tips action #delete" do
      { :post => 'api/tips/1' }.should route_to(:action => "destroy", :controller => "api/tips", :id => "1" )
    end
  end
end