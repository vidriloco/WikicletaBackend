require 'spec_helper'

describe Api::SessionsController do
  before(:each) do
    @user = FactoryGirl.create(:pipo)
  end
  
  describe "GET" do
    
    describe "with valid params" do
      
      before(:each) do
        @params = { :login => @user.username, :password => "passwd" }
      end
      
      it "should generate a valid json response" do
        get :create, :session => @params

        response.should be_successful
      end
      
      it "should retrieve the user details" do
        get :create, :session => @params

        response.body.should == @user.to_json
      end
      
    end
    
    describe "with invalid params" do
      
      before(:each) do
        @params = { :login => @user.username, :password => "bad-passwd" }
      end
      
      it "should generate an invalid json response" do
        get :create, :session => @params

        response.should_not be_successful
      end
      
    end
  end
end