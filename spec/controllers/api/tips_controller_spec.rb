require 'spec_helper'

describe Api::TipsController do
  before(:each) do
    @tip = FactoryGirl.build(:danger_tip)
    @user = FactoryGirl.stub(:pipo)
    
    @coords = {"lat" => "lat", "lon" => "lon"}
    @extras = {"auth_token" => "valid"}
    
    @params = {"some" => "params"}
  end
  
  describe "GET" do
    
    before(:each) do
      @tips = []
    end
    
    it "should generate a valid json response" do
      Tip.should_receive(:find_nearby).with(@params).and_return(@tips)
      get :index, :viewport => @params
    
      assigns(:tips).should == @tips
      response.should be_successful
    end
    
  end
  
  describe "POST" do
    
    describe "with bad auth token" do
      
      it "should not find a user" do
        stub_users_as(nil)
        post :create, :tip => @params, :extras => {"auth_token" => "bad"}, :coordinates => @coords
        
        assigns(:user).should be_nil
        response.should_not be_successful
        response.code.should eql("403")
      end
      
    end
    
    describe "with valid params" do
      
      before(:each) do
        @tip.stub(:save).and_return(true)
      end
      
      it "should save the tip" do
        should_retrieve_users_as([@user])
        Tip.should_receive(:new_with).with(@params, @coords, @user).and_return(@tip)
  
        post :create, :tip => @params, :extras => @extras, :coordinates => @coords
        response.should be_successful
      end
      
    end
    
    describe "with invalid params" do
      
      before(:each) do
        @tip.stub(:save).and_return(false)
      end
      
      it "should not save the tip" do
        stub_users_as(@user)
        Tip.should_receive(:new_with).with(@params, @coords, @user).and_return(@tip)
  
        post :create, :tip => @params, :extras => @extras, :coordinates => @coords
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
        @tip.stub(:update_with).and_return(true)
      end
      
      it "should find and update the tip" do
        should_retrieve_users_as([@user])
        Tip.should_receive(:find).with("1").and_return(@tip)
        
        put :update, :tip => @params, :extras => @extras, :coordinates => @coords, :id => "1"
        response.should be_successful
      end
      
    end
    
    describe "with invalid params" do
      
      before(:each) do
        @tip.stub(:update_with).and_return(false)
      end
      
      it "should find but not update the tip" do
        stub_users_as(@user)
        Tip.should_receive(:find).with("1").and_return(@tip)
        
        put :update, :tip => @params, :extras => @extras, :coordinates => @coords, :id => "1"
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
      
      describe "and tip destroyed" do
        
        before(:each) do
          @tip.stub(:destroy).and_return(true)
        end
        
        it "should respond with success" do
          Tip.should_receive(:find).with("1").and_return(@tip)

          delete :destroy, :extras => @extras, :id => "1"
          response.should be_successful
        end
        
      end
      
      describe "and tip NOT destroyed" do
        
        before(:each) do
          @tip.stub(:destroy).and_return(false)
        end
        
        it "should respond with success" do
          Tip.should_receive(:find).with("1").and_return(@tip)

          delete :destroy, :extras => @extras, :id => "1"
          response.should_not be_successful
        end
        
      end
    end

  end
  
end