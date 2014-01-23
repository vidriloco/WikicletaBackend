require "spec_helper"

describe Api::InstantsController do
  
  describe "API instants controller" do

    it "matches /api/instants with controller :instants action #create" do
      { :post => "/api/instants" }.should route_to(:action => "create", :controller => "api/instants")
    end
    
    it "matches /api/instants with controller :instants action #index" do
      { :get => "/api/instants/5/today" }.should route_to(:action => "index", :controller => "api/instants", :user_id => "5", :range => "today")
    end
    
  end
end