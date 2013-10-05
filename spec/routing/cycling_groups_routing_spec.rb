require "spec_helper"

describe Api::CyclingGroupsController do
  
  describe "API cycling-groups controller" do

    it "matches /api/cycling_groups? with controller :cycling_groups action #index" do
      { :get => "/api/cycling_groups" }.should route_to(:action => "index", :controller => "api/cycling_groups")
    end
    
  end
end