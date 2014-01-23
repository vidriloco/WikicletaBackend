require "spec_helper"

describe Api::InstantsController do
  
  describe "API instants controller" do

    it "matches /api/instants with controller :instants action #create" do
      { :post => "/api/instants" }.should route_to(:action => "create", :controller => "api/instants")
    end
    
  end
end