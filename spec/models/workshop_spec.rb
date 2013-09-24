#encoding: utf-8
require 'spec_helper'

describe Workshop do
  
  before(:each) do
    @user = FactoryGirl.create(:user, :username => "lelo")
  end
  
  describe "Given lelo submitted a workshop" do
    
    before(:each) do
      @workshop = FactoryGirl.create(:workshop_and_store)
      Ownership.create(:owned_object => @workshop, :user => @user, :kind => Ownership.category_for(:owner_types, :submitter))
    end
    
    it "he should be on the list of owners" do
      @workshop.owners.should == [{ :username => @user.username, :kind => Ownership.category_for(:owner_types, :submitter), :id => @user.id }]
    end
    
    it "he should appear as owner" do
      @workshop.owner.should == { :username => @user.username, :kind => Ownership.category_for(:owner_types, :submitter), :id => @user.id }
    end
    
    describe "and recently the workshop got verified by it's owner pipo" do
      before(:each) do
        @pipo = FactoryGirl.create(:pipo)
        Ownership.create(:owned_object => @workshop, :user => @pipo, :kind => Ownership.category_for(:owner_types, :owner))
      end
      
      it "should list two ownerships" do
        @workshop.owners.should == [{ :username => @user.username, :kind => Ownership.category_for(:owner_types, :submitter), :id => @user.id },
          { :username => @pipo.username, :kind => Ownership.category_for(:owner_types, :owner), :id => @pipo.id }]
      end

      it "should retrieve the owner of the workshop" do
        @workshop.owner.should == { :username => @pipo.username, :kind => Ownership.category_for(:owner_types, :owner), :id => @pipo.id }
      end
    end
  end
  
  describe "After having created a workshop" do
    
    before(:each) do
      @workshop=Workshop.new_with({:name => "A workshop", :details => "Some details", :store => true, :phone => 59493933}, {"lon" => -100.3000, "lat" => 25.6667}, @user)
      @workshop.save
    end
    
    it "should be associated with a list of owners" do
      @workshop.should be_persisted
      Ownership.first.user.should == @user
      Ownership.first.owned_object.should_not be_nil
      Ownership.first.owned_object.lon.should == -100.3000
      Ownership.first.owned_object.lat.should == 25.6667
    end
    
    it "should destroy it's associated objects upon destroy" do
      @workshop.destroy
      Ownership.first.should be_nil
    end

  end
  
end