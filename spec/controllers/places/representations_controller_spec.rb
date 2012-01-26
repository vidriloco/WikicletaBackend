# encoding: utf-8
require 'spec_helper'

describe Places::RepresentationsController do    
  
  before(:each) do
    @place = Factory(:recent_place)
  end
  
  describe "GET show" do
    
    it "should fetch a place and make it available to the view" do
      Place.should_receive(:find).with("1") { @place }
      get :show, :id => "1"
    
      assigns(:place).should == @place
      response.should be_successful
    end
  
  end
  
  describe "GET comments" do
    
    it "should fetch all the comments from a given place" do
      Place.with_comments("1") { @place }
      get :comments, :id => "1"
      assigns(:place).should == @place
    end
    
  end
  
end