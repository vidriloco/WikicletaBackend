#encoding: utf-8
require 'spec_helper'

describe Instant do
  
  before(:each) do
    @user = FactoryGirl.create(:user, :username => "lelo")
  end
    
  describe "Given a group of instants have just been received" do
    
    before(:each) do
      @bulk = [{:created_at=>"2014-01-22 19:25:20", :distance=>"", :elapsed_time=>"", :latitude=>"19.318966", :longitude=>"-99.128387", :speed=>""}, 
        {:created_at=>"2014-01-11 22:3:28", :distance=>"4.6494", :elapsed_time=>"10.727193", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10"},
        {:created_at=>"2014-01-11 5:27:28", :distance=>"1.6494", :elapsed_time=>"15.727193", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"20"}]
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
      Instant.last.speed.should == 20
      Instant.last.user.should == @user
      
      @user.distance.should == 6.2988
      @user.speed.should == 15
      
    end
    
    describe "and today were received a couple more" do
      
      before(:each) do
        @bulk = [{:created_at=>DateTime.new(2014, 1, 1, 12, 3, 22), :distance=>"3.22", :elapsed_time=>"20.22", :latitude=>"19.318966", :longitude=>"-99.128387", :speed=>"20.21"}, 
          {:created_at=>DateTime.new(2014, 1, 1, 5, 3, 6), :distance=>"6.30", :elapsed_time=>"30.56", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"15.4"},
          {:created_at=>DateTime.new(2014, 1, 2, 5, 3, 6), :distance=>"3.30", :elapsed_time=>"10.56", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"13.4"},
          {:created_at=>DateTime.new(2013, 12, 20, 5, 3, 6), :distance=>"3.30", :elapsed_time=>"10.56", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"13.4"}]
        Instant.bulk_create(@bulk, @user)
      end
      
      it "should bring the list of today's instants including the received ones only" do
        instants = Instant.all_within_range(@user.id, "2014-01-01 00:00:00", "2014-01-01 23:59:59")
        instants[:instants].count == 2
        
        instants[:instants].first.distance.should == 3.22
        instants[:instants].first.elapsed_time.should == 20
        instants[:instants].first.speed.should == 20.21
        instants[:instants].first.coordinates.lat.should == 19.318966
        
        instants[:instants].last.distance.should == 6.30
        instants[:instants].last.elapsed_time.should == 30
        instants[:instants].last.speed.should == 15.4
        instants[:instants].last.coordinates.lat.should == 19.346928
      end
      
      it "should bring the stats of today's instants" do
        Instant.all_within_range(@user.id, "2014-01-01 00:00:00", "2014-01-01 23:59:59")[:stats].should == {:speed => 17.805, :distance => 9.52}
      end
    end
  end
  
  describe "Given I was cycling and then stopped for more than 1000 seconds and did upload instants" do
    
    before(:each) do
      @bulk = [{:created_at=>"2014-01-22 19:25:20", :distance=>"", :elapsed_time=>"100", :latitude=>"19.318966", :longitude=>"-99.128387", :speed=>""}, 
        {:created_at=>"2014-01-11 22:3:28", :distance=>"5", :elapsed_time=>"23", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10"},
        {:created_at=>"2014-01-11 5:27:28", :distance=>"1", :elapsed_time=>"200", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10"},
        {:created_at=>"2014-01-11 5:29:28", :distance=>"1.5", :elapsed_time=>"400", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10"},
        {:created_at=>"2014-01-11 5:44:28", :distance=>"9", :elapsed_time=>"1200", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10"},
        {:created_at=>"2014-01-11 5:49:28", :distance=>"1", :elapsed_time=>"322", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10"}]
        Instant.bulk_create(@bulk, @user)
    end
    
    it "should only count the distance traveled between consecutive points in time" do
      @user.distance.should == 8.5
      @user.speed.should == 10
    end
  end
  
  describe "Given I jumped into the train and it tracked my trails" do
    
    before(:each) do
      @bulk = [{:created_at=>"2014-01-22 19:25:20", :distance=>"", :elapsed_time=>"100", :latitude=>"19.318966", :longitude=>"-99.128387", :speed=>"40"}, 
        {:created_at=>"2014-01-11 22:3:28", :distance=>"5", :elapsed_time=>"23", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10"},
        {:created_at=>"2014-01-11 5:27:28", :distance=>"1", :elapsed_time=>"200", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"49"},
        {:created_at=>"2014-01-11 5:29:28", :distance=>"1.5", :elapsed_time=>"400", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"67"}]
        Instant.bulk_create(@bulk, @user)
    end
    
    it "should not count them if I was going faster than 35 km/h" do
      @user.distance.should == 5
      @user.speed.should == 10
    end
    
  end
  
  describe "Given I have been cycling some days" do
    
    before(:each) do
      @day_one = [{:created_at=>"2014-01-22 19:25:20", :distance=>"", :elapsed_time=>"100", :latitude=>"19.318966", :longitude=>"-99.128387", :speed=>""}, 
        {:created_at=>"2014-01-22 22:3:28", :distance=>"5", :elapsed_time=>"23", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10"},
        {:created_at=>"2014-01-22 5:27:28", :distance=>"1", :elapsed_time=>"200", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10"},
        {:created_at=>"2014-01-22 5:29:28", :distance=>"1.5", :elapsed_time=>"400", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10"},
        {:created_at=>"2014-01-22 5:44:28", :distance=>"2", :elapsed_time=>"700", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10"},
        {:created_at=>"2014-01-22 5:49:28", :distance=>"1", :elapsed_time=>"322", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10"}]
        Instant.bulk_create(@day_one, @user)
      @day_two = [{:created_at=>"2014-01-21 19:25:20", :distance=>"", :elapsed_time=>"100", :latitude=>"19.318966", :longitude=>"-99.128387", :speed=>""}, 
        {:created_at=>"2014-01-21 22:3:28", :distance=>"5", :elapsed_time=>"23", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10"},
        {:created_at=>"2014-01-21 5:27:28", :distance=>"1", :elapsed_time=>"200", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10"},
        {:created_at=>"2014-01-21 5:29:28", :distance=>"1.5", :elapsed_time=>"400", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10"},
        {:created_at=>"2014-01-21 5:44:28", :distance=>"9", :elapsed_time=>"900", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10"},
        {:created_at=>"2014-01-21 5:49:28", :distance=>"1", :elapsed_time=>"322", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10"}]
        Instant.bulk_create(@day_two, @user)
      @day_three = [{:created_at=>"2014-01-19 5:26:10", :distance=>"", :elapsed_time=>"100", :latitude=>"19.318966", :longitude=>"-99.128387", :speed=>""}, 
        {:created_at=>"2014-01-19 5:27:10", :distance=>"1", :elapsed_time=>"23", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"6"},
        {:created_at=>"2014-01-19 5:27:28", :distance=>"1", :elapsed_time=>"200", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10"},
        {:created_at=>"2014-01-19 5:29:28", :distance=>"1", :elapsed_time=>"400", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10"},
        {:created_at=>"2014-01-19 5:44:28", :distance=>"1", :elapsed_time=>"900", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"10"},
        {:created_at=>"2014-01-19 5:49:28", :distance=>"1", :elapsed_time=>"322", :latitude=>"19.346928", :longitude=>"-99.111145", :speed=>"4"}]
        Instant.bulk_create(@day_three, @user)
    end
    
    it "should retrieve the stats for the days I request" do
      @stats = Instant.stats_for_day_on_range(@user, "2014-01-22", 5)
      
      @stats.size.should == 6
      
      @stats["2014-01-17"][:speed].to_f.should == 0
      @stats["2014-01-17"][:distance].to_f.should == 0
      
      @stats["2014-01-18"][:speed].to_f.should == 0
      @stats["2014-01-18"][:distance].to_f.should == 0
      
      @stats["2014-01-19"][:distance].to_f.should == 5
      @stats["2014-01-19"][:speed].to_f.should == 8
      
      @stats["2014-01-20"][:speed].to_f.should == 0
      @stats["2014-01-20"][:distance].to_f.should == 0
          
      @stats["2014-01-21"][:speed].to_f.should == 10
      @stats["2014-01-21"][:distance].to_f.should == 17.5
      
      @stats["2014-01-22"][:speed].to_f.should == 10
      @stats["2014-01-22"][:distance].to_f.should == 10.5
      
    end
    
  end
end