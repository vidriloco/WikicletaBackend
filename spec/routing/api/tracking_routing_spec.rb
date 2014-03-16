require "spec_helper"

describe Api::TrackingController do
  
  describe "API tracking controller" do

    it "matches /api/tracking/:code with controller :tracking action #show" do
      { :get => "/api/tracking/1" }.should route_to(:action => "show", :controller => "api/tracking", :code => "1")
    end
    
  end
end