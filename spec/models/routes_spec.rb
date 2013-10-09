#encoding: utf-8
require 'spec_helper'

describe Route do
  
  before(:each) do
    @user = FactoryGirl.create(:pipo)
    @params = {
      :updated_at     =>  "2013-10-09T01:08:03", 
      :details        =>  "todos los túneles del sur",
      :is_public      =>  false, 
      :name           =>  "Tunneling Route",
      :created_at     =>  "2013-10-09T01:08:03", 
      :kilometers     =>  4.5,
      :route_performance => {:average_speed => 7.5, :elapsed_time => 11000 },
      :instants       =>  [{:speed=>0.0, :time=>6000, :lon=>-99.1283703, :lat=>19.3188703}, {:speed=>15.0, :time=>10000, :lon=>-99.2283703, :lat=>19.2188703}]}
  end
  
  describe "Upon save with provided valid params" do
    
    before(:each) do
      @route = Route.new_with(@params, @user)
      @route.save
    end
    
    it "should save a route" do
      @route.should be_persisted
      @route.path.should_not be_nil
    end
    
    it "should set an owner" do
      @route.ownerships.first.should_not be_nil
      @route.ownerships.first.user.should == @user 
    end
    
    it "should set a new route_performance record associated to the given route" do
      @route.route_performances.count.should be(1)
      @route.route_performances.first.average_speed.should == 7.5
      @route.route_performances.first.elapsed_time.should == 11000
      @route.route_performances.first.user.should == @user
    end
    
    it "should associate a list of instants to a route_performance route" do
      @route.route_performances.first.instants.count.should be(2)
      @route.route_performances.first.instants.first.speed.to_f.should == 0
      @route.route_performances.first.instants.first.elapsed_time.should == 6000
      @route.route_performances.first.instants.first.coordinates.lat.should == 19.3188703
      @route.route_performances.first.instants.first.coordinates.lon.should == -99.1283703
      
      @route.route_performances.first.instants.last.speed.to_f.should == 15
      @route.route_performances.first.instants.last.elapsed_time.should == 10000
      @route.route_performances.first.instants.last.coordinates.lat.should == 19.2188703
      @route.route_performances.first.instants.last.coordinates.lon.should == -99.2283703
    end
    
  end
  
end