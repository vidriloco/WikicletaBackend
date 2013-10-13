require 'spec_helper'

describe Api::RoutesController do
  before(:each) do
    @route = FactoryGirl.build(:route)
    @user = FactoryGirl.stub(:pipo)
    
    @extras = {"auth_token" => "valid"}
    @params = {"some" => "params"}
  end
  
  describe "GET index" do
    
    before(:each) do
      @routes = []
    end
    
    it "should generate a valid json response"# do
      #Route.should_receive(:find_nearby_with).and_return(@routes)
      #get :index, :viewport => @params
    
      #assigns(:routes).should == @routes
      #response.should be_successful
    #end
    
  end
  
  describe "GET show" do
    
    it "should generate a valid json response for a given route"# do
      #Route.should_receive(:find).with("1").and_return(@routes)
      #get :show, :id => "1"
    
      #assigns(:route).should == @route
      #response.should be_successful
    #end
    
  end
  
  describe "GET performances" do
    
    it "should generate a valid json response for a given route" #do
      #Route.should_receive(:find).with("1").and_return(@routes)
      #get :performances, :id => "1"
    
      #assigns(:route).should == @route
      #response.should be_successful
    #end
    
  end
  
  describe "POST" do
    
    describe "with bad auth token" do
      
      it "should not find a user" do
        stub_users_as(nil)
        post :create, :route => @params, :extras => {"auth_token" => "bad"}
        
        assigns(:user).should be_nil
        response.should_not be_successful
        response.code.should eql("403")
      end
      
    end
    
    describe "with valid params" do
      
      before(:each) do
        @route.stub(:save).and_return(true)
      end
      
      it "should save the route" do
        should_retrieve_users_as([@user])
        Route.should_receive(:new_with).with(@params, @user).and_return(@route)
  
        post :create, :route => @params, :extras => @extras
        response.should be_successful
      end
      
    end
    
    describe "with invalid params" do
      
      before(:each) do
        @route.stub(:save).and_return(false)
      end
      
      it "should not save the route" do
        stub_users_as(@user)
        Route.should_receive(:new_with).with(@params, @user).and_return(@route)
  
        post :create, :route => @params, :extras => @extras
        response.should_not be_successful
      end
      
    end
    
  end
  
  describe "PUT" do
    
    describe "with bad auth token" do
      
      it "should not find a user" do
        stub_users_as(nil)
        put :update, :tip => @params, :extras => {"auth_token" => "bad"}, :coordinates => @coords, :id => "1"
        
        assigns(:user).should be_nil
        response.should_not be_successful
        response.code.should eql("403")
      end
      
    end
    
    describe "with valid params" do
      
      before(:each) do
        @route.stub(:update_attributes).and_return(true)
      end
      
      it "should find and update the route" do
        should_retrieve_users_as([@user])
        Route.should_receive(:find).with("1").and_return(@route)
        
        put :update, :route => @params, :extras => @extras, :id => "1"
        response.should be_successful
      end
      
    end
    
    describe "with invalid params" do
      
      before(:each) do
        @route.stub(:update_attributes).and_return(false)
      end
      
      it "should find but not update the route" do
        stub_users_as(@user)
        Route.should_receive(:find).with("1").and_return(@route)
        
        put :update, :route => @params, :extras => @extras, :id => "1"
        response.should_not be_successful
      end
      
    end
  end
  
  describe "DELETE" do
    
    describe "with bad auth token" do
      
      it "should not find a user" do
        stub_users_as(nil)
        delete :destroy, :extras => @extras, :id => "1"
        
        assigns(:user).should be_nil
        response.should_not be_successful
        response.code.should eql("403")
      end
      
    end

    describe "given auth token valid" do
      
      before(:each) do
        stub_users_as(@user)
      end
      
      describe "and route destroyed" do
        
        before(:each) do
          @route.stub(:destroy).and_return(true)
        end
        
        it "should respond with success" do
          Route.should_receive(:find).with("1").and_return(@route)

          post :destroy, :extras => @extras, :id => "1"
          response.should be_successful
        end
        
      end
      
      describe "and tip NOT destroyed" do
        
        before(:each) do
          @route.stub(:destroy).and_return(false)
        end
        
        it "should respond with success" do
          Route.should_receive(:find).with("1").and_return(@route)

          post :destroy, :extras => @extras, :id => "1"
          response.should_not be_successful
        end
        
      end
    end

  end
  
end