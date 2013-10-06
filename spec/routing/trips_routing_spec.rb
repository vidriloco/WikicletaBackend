require "spec_helper"

describe Api::TripsController do
  
  describe "API trips controller" do

    it "matches /api/trips? with controller :trips action #index" do
      { :get => "/api/trips" }.should route_to(:action => "index", :controller => "api/trips")
    end
    
  end
end