#encoding: utf-8
require 'spec_helper'

describe CyclePath do
  
  before(:each) do
    @user = FactoryGirl.create(:pipo)
    @params = {
      :updated_at     =>  "2013-10-09T01:08:03", 
      :details        =>  "Una ciclovia que va a funcionar muy bien",
      :name           =>  "Ciclovia Cd. de Bici",
      :created_at     =>  "2013-10-09T01:08:03", 
      :kilometers     =>  4.5,
      :one_way        => true}
    @path = "-99.34231 19.3149293 , -99.332423 19.423443 , -99.232423 19.323443"
  end
  
  describe "Upon save with provided valid params" do
    
    before(:each) do
      @cycle_path = CyclePath.new_with_path(@params, @user, @path)
      @cycle_path.save
    end
    
    it "should save a route" do
      @cycle_path.should be_persisted
      @cycle_path.path.should_not be_nil
      @cycle_path.origin_coordinate.lat.should == 19.3149293
      @cycle_path.origin_coordinate.lon.should == -99.34231
      @cycle_path.end_coordinate.lat.should == 19.323443
      @cycle_path.end_coordinate.lon.should == -99.232423
    end
    
    it "should set an owner" do
      @cycle_path.ownerships.first.should_not be_nil
      @cycle_path.ownerships.first.user.should == @user 
    end
    
    it "should generate a valid content hash" do
      @cycle_path.as_json.should == {
        "id" => @cycle_path.id,
        "name" => "Ciclovia Cd. de Bici",
        "details" => "Una ciclovia que va a funcionar muy bien",
        "kilometers" => @cycle_path.kilometers,
        "one_way" => true,
        :str_created_at => @cycle_path.created_at.to_s(:db),
        :str_updated_at => @cycle_path.updated_at.to_s(:db),
        :lat => 19.3149293,
        :lon => -99.34231, :owner => {
          :username => @user.username,
          :id => @user.id,
          :kind => 2
        },
        :path_vector => @cycle_path.path_vector
      }
    end
    
  end
  
end