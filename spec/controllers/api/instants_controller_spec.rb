require 'spec_helper'

describe Api::InstantsController do
  before(:each) do
    @user = FactoryGirl.stub(:pipo)
    
    @token_valid = {"auth_token" => "valid"}
    @token_invalid = {"auth_token" => "invalid"}
    
    @instants = [1,2]
    @params = [{"some" => "params"}]
  end
  
  describe "GET" do
    
    it "should fetch the list of instants" do
      Instant.should_receive(:all_within_range) { {} }
      get :index, :user_id => "1", :start_date => "yesterday", :end_date => "today" 
      assigns(:instants).should == {}
      response.should be_successful
    end
    
    it "should fetch the list of stats for a given day range" do
      Instant.should_receive(:stats_for_day_on_range).with("1", "2014-01-20", "5").and_return({})
      get :stats, :user_id => "1", :date => "2014-01-20", :range => 5
      assigns(:stats).should == {}
      response.should be_successful
    end
    
  end
  
  describe "POST" do
    
    describe "with bad auth token" do
      
      it "should not find a user" do
        stub_users_as(nil)
        post :create, :instants => @params, :extras => @token_invalid
        
        assigns(:user).should be_nil
        response.should_not be_successful
        response.code.should eql("403")
      end
      
    end
    
    describe "with valid params" do
      
      before(:each) do
        Instant.stub(:bulk_create, @user).and_return(@instants)
      end
      
      it "hould have a NON empty instants list" do
        should_retrieve_users_as([@user])
        
        post :create, :instants => @params, :extras => @token_valid
        assigns(:instants).should == @instants
        
        response.should be_successful
      end
      
    end
    
    describe "with invalid params" do
      
      before(:each) do
        Instant.stub(:bulk_create, @user).and_return([])
      end
      
      it "should have an empty instants list" do
        should_retrieve_users_as([@user])
        
        post :create, :instants => @params, :extras => @token_valid
        assigns(:instants).should == []
        
        response.should_not be_successful
      end
      
    end
    
  end
end