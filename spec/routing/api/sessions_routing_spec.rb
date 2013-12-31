require "spec_helper"

describe Api::SessionsController do
  
  describe "API sessions controller" do

    it "matches /api/users/sign_in with controller :sessions action #create" do
      { :post => "/api/users/sign_in" }.should route_to(:action => "create", :controller => "api/sessions")
    end
    
  end
end