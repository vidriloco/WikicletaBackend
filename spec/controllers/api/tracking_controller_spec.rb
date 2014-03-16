require 'spec_helper'

describe Api::TrackingController do
  
  describe "GET show" do
    
    before(:each) do
      @user = FactoryGirl.create(:pipo, :tracking_number => "34d2md", :tracking_number_last_reset_at => DateTime.now)
    end
    
    it "should generate a valid json response" do
      User.should_receive(:where).with(:tracking_number => "34d2md") { [@user] }
      get :show, :code => "34d2md"
    
      assigns(:user).should == @user
      response.should be_successful
    end
    
  end
end