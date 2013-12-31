#encoding: utf-8
require 'spec_helper'

describe Parking do
  
  before(:each) do
    @user = FactoryGirl.create(:user, :username => "lelo")
  end
  
  describe "Given lelo submitted a parking slot" do
    
    before(:each) do
      @parking = FactoryGirl.create(:parking)
      Ownership.create(:owned_object => @parking, :user => @user, :kind => Ownership.category_for(:owner_types, :submitter))
    end
    
    it "he should be on the list of owners" do
      @parking.owners.should == [{ :username => @user.username, :kind => Ownership.category_for(:owner_types, :submitter), :id => @user.id }]
    end
    
    it "he should appear as owner" do
      @parking.owner.should == { :username => @user.username, :kind => Ownership.category_for(:owner_types, :submitter), :id => @user.id }
    end
        
    describe "and recently the parking got verified by it's owner: pipo" do
      before(:each) do
        @pipo = FactoryGirl.create(:pipo)
        Ownership.create(:owned_object => @parking, :user => @pipo, :kind => Ownership.category_for(:owner_types, :owner))
      end
      
      it "should list two ownerships" do
        @parking.owners.should == [{ :username => @user.username, :kind => Ownership.category_for(:owner_types, :submitter), :id => @user.id },
          { :username => @pipo.username, :kind => Ownership.category_for(:owner_types, :owner), :id => @pipo.id }]
      end

      it "should retrieve the owner of the parking" do
        @parking.owner.should == { :username => @pipo.username, :kind => Ownership.category_for(:owner_types, :owner), :id => @pipo.id }
      end
    end
  end
  
  describe "After having created a parking" do
    
    before(:each) do
      @parking=Parking.new_with({:details => "Some details", :has_roof => true, :kind => Parking.category_for(:kinds, :venue_provided)}, {"lon" => -100.3000, "lat" => 25.6667}, @user)
      @parking.save
    end
    
    it "should be associated with a list of owners" do
      @parking.should be_persisted
      Ownership.first.user.should == @user
      Ownership.first.owned_object.should_not be_nil
      Ownership.first.owned_object.lon.should == -100.3000
      Ownership.first.owned_object.lat.should == 25.6667
    end
    
    it "should generate a valid response dictionary for the sightseeing tip" do
      @parking.as_json.should == {
        "id" => @parking.id, 
        "details" => @parking.details,
        "kind" => 3, 
        "likes_count" => 0, 
        "dislikes_count" => 0,
        "has_roof" => true,
        :str_created_at => @parking.created_at.to_s(:db),
        :str_updated_at => @parking.updated_at.to_s(:db),
        :lat => 25.6667,
        :lon => -100.3000, :owner => {
          :username => @user.username,
          :id => @user.id,
          :kind => 2
        }}
    end
    
    it "should destroy it's associated objects upon destroy" do
      @parking.destroy
      Ownership.first.should be_nil
    end
    
    describe "given he modified it" do
      
      before(:each) do
        @parking.update_with({:details => "Bad parking", :has_roof => false, :kind => Parking.category_for(:kinds, :government_provided)}, {"lon" => -99.1894, "lat" => 19.6667})
      end
      
      it "should be able to find it and see it's updated fields" do
        Parking.first.as_json.should == {
          "id" => @parking.id, 
          "details" => "Bad parking",
          "kind" => 1, 
          "likes_count" => 0, 
          "dislikes_count" => 0,
          "has_roof" => false,
          :str_created_at => @parking.created_at.to_s(:db),
          :str_updated_at => @parking.updated_at.to_s(:db),
          :lat => 19.6667,
          :lon => -99.1894, :owner => {
            :username => @user.username,
            :id => @user.id,
            :kind => 2
          }}
      end
      
    end

  end
  
end