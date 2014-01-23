#encoding: utf-8
require 'spec_helper'

describe Instant do
  
  before(:each) do
    @user = FactoryGirl.create(:user, :username => "lelo")
  end
  
  describe "Given a group of instants have just been received" do
    
    before(:each) do
      @bulk = [{:created_at=>"2014-01-22 19:25:20", :distance=>"", :elapsed_time=>"", :latitude=>"19.318966", :longitude=>"-99.128387", :speed=>""}, 
        {:created_at=>"2014-01-11 22:3:28", :distance=>"4.6494", :elapsed_time=>"10.727193", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10.425293"},
        {:created_at=>"2014-01-11 5:27:28", :distance=>"1.6494", :elapsed_time=>"15.727193", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"8165.425293"}]
    end
    
    it "should save them" do
      expect{ Instant.bulk_create(@bulk, @user) }.to change{Instant.count}.from(0).to(3)
      
      Instant.first.created_at.should == DateTime.new(2014,1,22, 19, 25, 20)
      Instant.first.distance.should == nil
      Instant.first.elapsed_time.should == nil
      Instant.first.coordinates.lat.should == 19.318966
      Instant.first.coordinates.lon.should == -99.128387
      Instant.first.speed.should == nil
      Instant.first.user.should == @user
      
      Instant.last.created_at.should == DateTime.new(2014,1,11, 5, 27, 28)
      Instant.last.distance.should == 1.6494
      Instant.last.elapsed_time.should == 15
      Instant.last.coordinates.lat.should == 19.346928
      Instant.last.coordinates.lon.should == -99.111145
      Instant.last.speed.should == 8165.425293
      Instant.last.user.should == @user
      
      @user.distance.should == 6.2988
      @user.speed.should == 4087.925293
      
    end
    
    describe "and today were received a couple more" do
      
      before(:each) do
        @bulk = [{:created_at=>DateTime.now.to_s(:db), :distance=>"3.22", :elapsed_time=>"20.22", :latitude=>"19.318966", :longitude=>"-99.128387", :speed=>"20.21"}, 
          {:created_at=>DateTime.now.to_s(:db), :distance=>"6.30", :elapsed_time=>"30.56", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"15.4"}]
        Instant.bulk_create(@bulk, @user)
      end
      
      it "should bring the list of today's instants including the received ones only" do
        Instant.all_within_range(@user.id, "today")[:instants].count == 2
        Instant.all_within_range(@user.id, "today")[:instants].last.distance.should == 6.30
        Instant.all_within_range(@user.id, "today")[:instants].last.elapsed_time.should == 30
        Instant.all_within_range(@user.id, "today")[:instants].last.speed.should == 15.4
        Instant.all_within_range(@user.id, "today")[:instants].last.coordinates.lat.should == 19.346928
        
        Instant.all_within_range(@user.id, "today")[:instants].first.distance.should == 3.22
        Instant.all_within_range(@user.id, "today")[:instants].first.elapsed_time.should == 20
        Instant.all_within_range(@user.id, "today")[:instants].first.speed.should == 20.21
        Instant.all_within_range(@user.id, "today")[:instants].first.coordinates.lat.should == 19.318966
      end
      
      it "should bring the stats of today's instants" do
        Instant.all_within_range(@user.id, "today")[:stats].should == {:speed => 17.805, :distance => 9.52}
      end
    end
  end
  
end