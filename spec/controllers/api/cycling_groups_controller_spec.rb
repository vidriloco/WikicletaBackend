require 'spec_helper'

describe Api::CyclingGroupsController do
  before(:each) do    
    @coords = {"lat" => "lat", "lon" => "lon"}
    @extras = {"auth_token" => "valid"}
    
    @params = {"some" => "params"}
  end
  
  describe "GET" do
    
    before(:each) do
      @cycling_groups = []
    end
    
    it "should generate a valid json response" do
      CyclingGroup.should_receive(:find_nearby_with).and_return(@cycling_groups)
      get :index, :viewport => @params
    
      assigns(:cycling_groups).should == @cycling_groups
      response.should be_successful
    end
    
  end
end