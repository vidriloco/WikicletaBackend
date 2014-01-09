require "spec_helper"

describe Api::CyclePathsController do
  
  describe "API cycle-paths controller" do

    it "matches /api/cycle_paths? with controller :cycle_paths action #index" do
      { :get => "/api/cycle_paths" }.should route_to(:action => "index", :controller => "api/cycle_paths")
    end
    
  end
end