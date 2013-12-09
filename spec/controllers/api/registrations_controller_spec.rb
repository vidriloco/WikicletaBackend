require 'spec_helper'

describe Api::RegistrationsController do
  
  describe "POST" do
    
    context "with valid attributes" do 
      
      before(:each) do
        @params = FactoryGirl.attributes_for(:pipo) 
      end
      
      it "creates a new user" do 
        expect{ 
          post :create, registration: @params
        }.to change(User,:count).by(1) 
      end 
      
      it "generates a json response with the user data" do 
        post :create, registration: @params
        response.body.should == User.last.to_json
      end
      
      it "replies with a successful response" do
        post :create, registration: @params
        response.should be_successful
      end 
    end
    
    context "with invalid attributes" do
      
      before(:each) do
        @params = FactoryGirl.attributes_for(:pipo)
        @params.delete(:full_name)
      end
      
      it "doesn't create a new user" do 
        expect{ 
          post :create, registration: @params
        }.to change(User, :count).by(0) 
      end 
      
      it "generates a json response with the user data" do 
        post :create, registration: @params
        response.body.should == {:errors => {:full_name => ["no puede estar en blanco"] } }.to_json
      end
      
      it "replies with a successful response" do
        post :create, registration: @params
        response.should_not be_successful
      end
      
    end
    
  end
end