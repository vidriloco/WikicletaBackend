require "spec_helper"

describe Api::TipsController do
  
  describe "API tips controller" do

    it "matches /api/tips? with controller :tips action #index" do
      { :get => "/api/tips" }.should route_to(:action => "index", :controller => "api/tips")
    end
    
  end
end