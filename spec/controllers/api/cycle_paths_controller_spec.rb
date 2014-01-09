require 'spec_helper'

describe Api::CyclePathsController do
  
  describe "GET" do
    
    before(:each) do
      @cycle_paths = []
    end
    
    it "should generate a valid json response" do
      CyclePath.should_receive(:find_nearby).with(@params).and_return(@cycle_paths)
      get :index, :viewport => @params
    
      assigns(:cycle_paths).should == @cycle_paths
      response.should be_successful
    end
    
  end
end