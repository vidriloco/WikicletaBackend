require "spec_helper"

describe Api::InstantsController do
  
  describe "API instants controller" do

    it "matches /api/instants with controller :instants action #create" do
      { :post => "/api/instants" }.should route_to(:action => "create", :controller => "api/instants")
    end
    
    it "matches /api/instants/5/stats with controller :instants action #stats" do
      { :get => "/api/instants/5/stats" }.should route_to(:action => "stats", :controller => "api/instants", :user_id => "5")
    end
    
    it "matches /api/instants with controller :instants action #index" do
      { :get => "/api/instants/5" }.should route_to(:action => "index", :controller => "api/instants", :user_id => "5")
    end
    
  end
end