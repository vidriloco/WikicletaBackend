require 'spec_helper'

describe Api::WorkshopsController do
  before(:each) do
    @workshop = FactoryGirl.build(:workshop_and_store)
    @user = FactoryGirl.stub(:pipo)
    
    @coords = {"lat" => "lat", "lon" => "lon"}
    
    @token_valid = {"auth_token" => "valid"}
    @token_invalid = {"auth_token" => "invalid"}
    
    @params = {"some" => "params"}
  end
  
  describe "GET" do
    
    before(:each) do
      @workshops = []
    end
    
    it "should generate a valid json response" do
      Workshop.should_receive(:find_nearby).with(@params).and_return(@workshops)
      get :index, :viewport => @params
    
      assigns(:workshops).should == @workshops
      response.should be_successful
    end
    
  end
  
  describe "POST" do
    
    describe "with bad auth token" do
      
      it "should not find a user" do
        stub_users_as(nil)
        post :create, :workshop => @params, :extras => @token_invalid, :coordinates => @coords
        
        assigns(:user).should be_nil
        response.should_not be_successful
        response.code.should eql("403")
      end
      
    end
    
    describe "with valid params" do
      
      before(:each) do
        @workshop.stub(:save).and_return(true)
      end
      
      it "should save the workshop" do
        should_retrieve_users_as([@user])
        Workshop.should_receive(:new_with).with(@params, @coords, @user).and_return(@workshop)
  
        post :create, :workshop => @params, :extras => @token_valid, :coordinates => @coords
        response.should be_successful
      end
      
    end
    
    describe "with invalid params" do
      
      before(:each) do
        @workshop.stub(:save).and_return(false)
      end
      
      it "should not save the workshop" do
        stub_users_as(@user)
        Workshop.should_receive(:new_with).with(@params, @coords, @user).and_return(@workshop)
  
        post :create, :workshop => @params, :extras => @token_invalid, :coordinates => @coords
        response.should_not be_successful
      end
      
    end
    
  end
  
  describe "PUT" do
    
    describe "with bad auth token" do
      
      it "should not find a user" do
        stub_users_as(nil)
        put :update, :workshop => @params, :extras => @token_invalid, :coordinates => @coords, :id => "1"
        
        assigns(:user).should be_nil
        response.should_not be_successful
        response.code.should eql("403")
      end
      
    end
    
    describe "with valid params" do
      
      before(:each) do
        @workshop.stub(:update_with).and_return(true)
      end
      
      it "should save the workshop" do
        should_retrieve_users_as([@user])
        Workshop.should_receive(:find).with("1").and_return(@workshop)
  
        put :update, :workshop => @params, :extras => @token_valid, :coordinates => @coords, :id => "1"
        response.should be_successful
      end
      
    end
    
    describe "with invalid params" do
      
      before(:each) do
        @workshop.stub(:update_with).and_return(false)
      end
      
      it "should not save the workshop" do
        stub_users_as(@user)
        Workshop.should_receive(:find).with("1").and_return(@workshop)
  
        put :update, :workshop => @params, :extras => @token_invalid, :coordinates => @coords, :id => "1"
        response.should_not be_successful
      end
      
    end
  end
  
  describe "DELETE" do
    
    describe "with bad auth token" do
      
      it "should not find a user" do
        stub_users_as(nil)
        delete :destroy, :extras => @token_invalid, :id => "1"
        
        assigns(:user).should be_nil
        response.should_not be_successful
        response.code.should eql("403")
      end
      
    end

    describe "given auth token valid" do
      
      before(:each) do
        stub_users_as(@user)
      end
      
      describe "and workshop destroyed" do
        
        before(:each) do
          @workshop.stub(:destroy).and_return(true)
        end
        
        it "should respond with success" do
          Workshop.should_receive(:find).with("1").and_return(@workshop)

          delete :destroy, :extras => @token_valid, :id => "1"
          response.should be_successful
        end
        
      end
      
      describe "and workshop NOT destroyed" do
        
        before(:each) do
          @workshop.stub(:destroy).and_return(false)
        end
        
        it "should respond with success" do
          Workshop.should_receive(:find).with("1").and_return(@workshop)

          delete :destroy, :extras => @token_invalid, :id => "1"
          response.should_not be_successful
        end
        
      end
    end

  end
end