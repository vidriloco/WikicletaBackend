require "spec_helper"

describe Api::RegistrationsController do
  
  describe "API registrations controller" do

    it "matches /api/users with controller :registrations action #create" do
      { :post => "/api/users" }.should route_to(:action => "create", :controller => "api/registrations")
    end
        
  end
end