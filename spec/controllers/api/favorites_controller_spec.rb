require 'spec_helper'

describe Api::FavoritesController do
  
  before(:each) do
    @params = {"more" => "params"}
    @user = FactoryGirl.stub(:pipo)
  end
  
  describe "POST mark" do
    
    it "should mark a favorite" do
      should_retrieve_users_as([@user])
      Favorite.should_receive(:mark).with(@params)
      post :mark, :favorite => @params, :extras => {}
      response.should be_successful
    end
    
  end
  
  describe "POST unmark" do
    
    it "should unmark a favorite" do
      should_retrieve_users_as([@user])
      Favorite.should_receive(:unmark).with(@params)
      post :unmark, :favorite => @params, :extras => {}
      response.should be_successful
    end
    
  end
  
  describe "GET" do
    
    it "should get the status of a favorite" do
      Favorite.should_receive(:favorite?)
      get :marked?, :favorited_object_id => "1", :favorited_object_type => "Type", :user_id => "1"
      response.should be_successful
    end
    
  end
end