require 'spec_helper'

describe Api::ParkingsController do
  before(:each) do
    @parking = FactoryGirl.build(:parking)
    @user = FactoryGirl.stub(:pipo)
    
    @coords = {"lat" => "lat", "lon" => "lon"}
    @extras = {"auth_token" => "valid"}
    
    @params = {"some" => "params"}
  end
  
  describe "GET" do
    
    before(:each) do
      @parkings = []
    end
    
    it "should generate a valid json response" do
      Parking.should_receive(:find_nearby).with(@params).and_return(@parkings)
      get :index, :viewport => @params
    
      assigns(:parkings).should == @parkings
      response.should be_successful
    end
    
  end
  
  describe "POST" do
    
    describe "with bad auth token" do
      
      it "should not find a user" do
        stub_users_as(nil)
        post :create, :parking => @params, :extras => {"auth_token" => "bad"}, :coordinates => @coords
        
        assigns(:user).should be_nil
        response.should_not be_successful
        response.code.should eql("403")
      end
      
    end
    
    describe "with valid params" do
      
      before(:each) do
        @parking.stub(:save).and_return(true)
      end
      
      it "should save the parking" do
        should_retrieve_users_as([@user])
        Parking.should_receive(:new_with).with(@params, @coords, @user).and_return(@parking)
  
        post :create, :parking => @params, :extras => @extras, :coordinates => @coords
        response.should be_successful
      end
      
    end
    
    describe "with invalid params" do
      
      before(:each) do
        @parking.stub(:save).and_return(false)
      end
      
      it "should not save the parking" do
        stub_users_as(@user)
        Parking.should_receive(:new_with).with(@params, @coords, @user).and_return(@parking)
  
        post :create, :parking => @params, :extras => @extras, :coordinates => @coords
        response.should_not be_successful
      end
      
    end
    
  end
  
  describe "PUT" do
    
    describe "with bad auth token" do
      
      it "should not find a user" do
        stub_users_as(nil)
        put :update, :parking => @params, :extras => {"auth_token" => "bad"}, :coordinates => @coords, :id => "1"
        
        assigns(:user).should be_nil
        response.should_not be_successful
        response.code.should eql("403")
      end
      
    end
    
    describe "with valid params" do
      
      before(:each) do
        @parking.stub(:update_with).and_return(true)
      end
      
      it "should save the parking" do
        should_retrieve_users_as([@user])
        Parking.should_receive(:find).with("1").and_return(@parking)
  
        put :update, :parking => @params, :extras => @extras, :coordinates => @coords, :id => "1"
        response.should be_successful
      end
      
    end
    
    describe "with invalid params" do
      
      before(:each) do
        @parking.stub(:update_with).and_return(false)
      end
      
      it "should not save the workshop" do
        stub_users_as(@user)
        Parking.should_receive(:find).with("1").and_return(@parking)
  
        put :update, :parking => @params, :extras => @extras, :coordinates => @coords, :id => "1"
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
      
      describe "and parking destroyed" do
        
        before(:each) do
          @parking.stub(:destroy).and_return(true)
        end
        
        it "should respond with success" do
          Parking.should_receive(:find).with("1").and_return(@parking)

          delete :destroy, :extras => @extras, :id => "1"
          response.should be_successful
        end
        
      end
      
      describe "and parking NOT destroyed" do
        
        before(:each) do
          @parking.stub(:destroy).and_return(false)
        end
        
        it "should respond with success" do
          Parking.should_receive(:find).with("1").and_return(@parking)

          delete :destroy, :extras => @extras, :id => "1"
          response.should_not be_successful
        end
        
      end
    end

  end
end