require "spec_helper"

describe Api::WorkshopsController do
  
  describe "API workshops controller" do

    it "matches /api/workshops? with controller :workshops action #index" do
      { :get => "/api/workshops" }.should route_to(:action => "index", :controller => "api/workshops")
    end
    
    it "matches /api/workshops with controller :workshops action #create" do
      { :post => 'api/workshops' }.should route_to(:action => "create", :controller => "api/workshops")
    end
    
    it "matches /api/workshops/:id with controller :workshops action #update" do
      { :put => 'api/workshops/1' }.should route_to(:action => "update", :controller => "api/workshops", :id => "1" )
    end
    
    it "matches /api/workshops/:id with controller :workshops action #delete" do
      { :post => 'api/workshops/1' }.should route_to(:action => "destroy", :controller => "api/workshops", :id => "1" )
    end
  end
end