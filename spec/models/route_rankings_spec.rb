#encoding: utf-8
require 'spec_helper'

describe RouteRanking do
  
  before(:each) do
    @pipo = FactoryGirl.create(:pipo)
    @pancho = FactoryGirl.create(:pancho)
  end

  describe "Given there is a route" do
    
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
      @route = Route.new_with(@params, @pipo)
      @route.save
    end
    
    describe "and provided Pipo ranks it" do
      
      before(:each) do
        fields = {
          :speed_index => 1, 
          :safety_index => 1, 
          :comfort_index => 2, 
          :route_id => @route.id}
        @route_ranking = RouteRanking.new_or_find_with(fields, @pipo).save_or_update(fields)
      end
      
      it "should have persisted it" do
        @route_ranking.should be(true)
      end
      
      it "should have set all of it's associated models" do
        route_ranking = RouteRanking.where(:user_id => @pipo.id, :route_id => @route.id).first
        route_ranking.route.should == @route
        route_ranking.user.should == @pipo
      end
      
      it "should have set all of it's associated fields" do
        route_ranking = RouteRanking.where(:user_id => @pipo.id, :route_id => @route.id).first
        route_ranking.route.speed_index.should == 1
        route_ranking.route.safety_index.should == 1
        route_ranking.route.comfort_index.should == 2
      end
      
      describe "and provided pancho also ranks it" do
        
        before(:each) do
          fields = {
            :speed_index => 3, 
            :safety_index => 3, 
            :comfort_index => 3, 
            :route_id => @route.id}
          @second_route_ranking = RouteRanking.new_or_find_with(fields, @pancho).save_or_update(fields)
        end
        
        it "should have persisted it" do
          @second_route_ranking.should be(true)
        end

        it "should have set all of it's associated models" do
          route_ranking = RouteRanking.where(:user_id => @pancho.id, :route_id => @route.id).first
          route_ranking.route.should == @route
          route_ranking.user.should == @pancho
        end

        it "should have set all of it's associated fields" do
          route_ranking = RouteRanking.where(:user_id => @pancho.id, :route_id => @route.id).first
          route_ranking.route.speed_index.should == 2
          route_ranking.route.safety_index.should == 2
          route_ranking.route.comfort_index.should == 2
        end
        
        it "the route ranked by pipo and pancho should have two rankings" do
          @route.route_rankings.count.should == 2
        end
        
      end
      
      describe "after some time he decides to adjust his ranking" do
      
        before(:each) do
          fields = {
            :speed_index => 3, 
            :safety_index => 3, 
            :comfort_index => 3, 
            :route_id => @route.id}
          @route_ranking = RouteRanking.new_or_find_with(fields, @pipo).save_or_update(fields)
        end
        
        it "should have updated it" do
          @route_ranking.should be(true)
        end

        it "should mantain all of it's associated models" do
          route_ranking = RouteRanking.where(:user_id => @pipo.id, :route_id => @route.id).first
          route_ranking.route.should == @route
          route_ranking.user.should == @pipo
        end

        it "should have updated all of it's associated fields" do
          route_ranking = RouteRanking.where(:user_id => @pipo.id, :route_id => @route.id).first
          route_ranking.route.speed_index.should == 3
          route_ranking.route.safety_index.should == 3
          route_ranking.route.comfort_index.should == 3
        end
        
      end
      
      
    end
    
  end
  
end