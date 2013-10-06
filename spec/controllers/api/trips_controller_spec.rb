require 'spec_helper'

describe Api::TripsController do
  before(:each) do    
    @coords = {"lat" => "lat", "lon" => "lon"}
    @extras = {"auth_token" => "valid"}
    
    @params = {"some" => "params"}
  end
  
  describe "GET" do
    
    before(:each) do
      @trips = []
    end
    
    it "should generate a valid json response" do
      Trip.should_receive(:find_nearby_with).and_return(@trips)
      get :index, :viewport => @params
    
      assigns(:trips).should == @trips
      response.should be_successful
    end
    
  end
end