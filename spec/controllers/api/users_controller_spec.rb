require 'spec_helper'

describe Api::UsersController do
  before(:each) do
    @user = FactoryGirl.create(:pipo)
    
    @coords = {"lat" => "lat", "lon" => "lon"}
    @extras = {"auth_token" => "valid"}
    
    @params = {"some" => "params"}
  end
  
  describe "GET" do
    
    it "should generate a valid json response containing the user's profile data" do
      User.should_receive(:find) { @user }
      get :profile, :id => @user.id
    
      assigns(:user).should == @user
      response.should be_successful
    end
    
  end
  
  describe "POST" do
    
    describe "with bad auth token" do
      
      it "should not find a user" do
        stub_users_as(nil)
        post :update, :id => @user.id, :extras => {"auth_token" => "bad"}
        
        assigns(:user).should be_nil
        response.should_not be_successful
        response.code.should eql("403")
      end
      
    end
    
    describe "with valid params" do
      
      before(:each) do
        @user.stub(:update_with).and_return(true)
      end
      
      it "should update the user" do
        should_retrieve_users_as([@user])
  
        post :update, :user => @params, :extras => @extras
        response.should be_successful
      end
      
    end
    
    describe "with invalid params" do
      
      before(:each) do
        @user.stub(:update_with).and_return(false)
      end
      
      it "should not update the user" do
        should_retrieve_users_as([@user])
  
        post :update, :user => @params, :extras => @extras
        response.should_not be_successful
      end
      
    end
    
  end 
  
end