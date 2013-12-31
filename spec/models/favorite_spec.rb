#encoding: utf-8
require 'spec_helper'

describe Favorite do
  
  before(:each) do
    @user = FactoryGirl.create(:user)
  end
  
  describe "for a given route" do
    
    before(:each) do
      @params = {
        :updated_at     =>  "2013-10-09T01:08:03", 
        :details        =>  "todos los túneles del sur",
        :is_public      =>  false, 
        :name           =>  "Tunneling Route",
        :created_at     =>  "2013-10-09T01:08:03", 
        :kilometers     =>  4.5,
        :route_performance => {:average_speed => 7.5, :elapsed_time => 11000 },
        :instants       =>  [{:speed=>0.0, :time=>6000, :lon=>-99.1283703, :lat=>19.3188703}, {:speed=>15.0, :time=>10000, :lon=>-99.2283703, :lat=>19.2188703}]}
      @route = Route.new_with(@params, @user)
      @route.save
    end
    
    describe "when marking it as favorite" do
      
      before(:each) do
        @favorite = Favorite.mark(:user_id => @user.id, :favorited_object_id => @route.id, :favorited_object_type => @route.class.to_s)
      end
      
      it "marks the route as favorited by @user" do
        @favorite.user.should == @user
        @favorite.favorited_object.should == @route
      end
      
      it "should be listed as favorite on @user favorites" do
        @user.favorited_routes.should == [@route]
      end
      
      it "should list the users who made it favorite" do
        @route.favorites.should == [@favorite]
      end
      
    end
    
    describe "when already marked-it as favorite" do
      
      before(:each) do
        Favorite.mark(:user_id => @user.id, :favorited_object_id => @route.id, :favorited_object_type => @route.class.to_s)
      end
      
      it "should unmark-it after calling .toogle" do
        Favorite.unmark(:user_id => @user.id, :favorited_object_id => @route.id, :favorited_object_type => @route.class.to_s)
        Favorite.where(:user_id => @user.id, :favorited_object_id => @route.id, :favorited_object_type => @route.class.to_s).should == []
      end
      
    end

  end
  
end