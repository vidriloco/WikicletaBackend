#encoding: utf-8
require 'spec_helper'

describe Tip do
  
  describe "Pipo is a registered user" do
    before(:each) do
      @owner = FactoryGirl.create(:pipo)
    end
    
    it "should NOT let him create a tip when no content provided" do
      @tip = Tip.new_with({
        "content" => "",
        "category" => Tip.category_for(:categories, :alert)
      }, {"lon" => "-99.13929848000407", "lat" => "19.38650804236533"}, @owner)
      
      @tip.save.should be(false)
    end
    
    describe "thus, he should be able to create a tip" do
      
      before(:each) do
        @danger_attrs = FactoryGirl.attributes_for(:danger_tip)
      end
      
      describe "given he provided valid params" do
        
        before(:each) do
          @tip  = Tip.new_with({
            "content" => "some valid content",
            "category" => Tip.category_for(:categories, :danger)
          }, {"lon" => "-99.13929848000407", "lat" => "19.38650804236533"}, @owner)
        end
        
        it "should get his tip saved" do
          expect{ @tip.save }.to change{Tip.count}.from(0).to(1)
        end
        
        describe "given his tip got saved" do
          
          before(:each) do
            @tip.save
          end
          
          it "should appear when looking for it on the correct map viewport that encapsulates it" do
            found=Tip.find_nearby({:sw => "19.373480,-99.146977", :ne => "19.412341,-99.119511"})
            found.size.should be(1)
            found[0].should == @tip
            found[0].lon.should == -99.13929848000407
            found[0].lat.should == 19.38650804236533
            found[0].category.should == 1
            found[0].content.should == "some valid content"
            found[0].owner.should == { :username => @owner.username, :id => @owner.id }
          end
          
          it "should NOT appear when looking for it on a bad map viewport that DOESN'T encapsulates it" do
            found=Tip.find_nearby({:sw => "17.555617,-99.944414", :ne => "17.594892,-99.916948"})
            found.size.should be(0)
          end
        end
        
      end
    end
  
    describe "given he created two tips and Pancho other" do
      
      before(:each) do
        @alert = FactoryGirl.create(:alert_tip, :user => @owner)
        @pancho = FactoryGirl.create(:pancho)
        @danger = FactoryGirl.create(:danger_tip, :user => @pancho)
        @sightseeing = FactoryGirl.create(:sightseeing_tip, :user => @owner)
      end
      
      it "should generate a valid response dictionary for the alert tip" do
        @alert.as_json.should == {
          "id" => @alert.id, 
          "content" => @alert.content,
          "category" => 2, 
          "likes_count" => 0, 
          "dislikes_count" => 0,
          :str_created_at => @alert.created_at.to_s(:db),
          :str_updated_at => @alert.updated_at.to_s(:db),
          :lat => @alert.coordinates.lat,
          :lon => @alert.coordinates.lon, :owner => {
            :username => @owner.username,
            :id => @owner.id
          }}
      end
      
      it "should generate a valid response dictionary for the danger tip" do
        @danger.as_json.should == {
          "id" => @danger.id, 
          "content" => @danger.content,
          "category" => 1, 
          "likes_count" => 0, 
          "dislikes_count" => 0,
          :str_created_at => @danger.created_at.to_s(:db),
          :str_updated_at => @danger.updated_at.to_s(:db),
          :lat => @danger.coordinates.lat,
          :lon => @danger.coordinates.lon, :owner => {
            :username => @pancho.username,
            :id => @pancho.id
          }}
      end
      
      it "should generate a valid response dictionary for the sightseeing tip" do
        @sightseeing.as_json.should == {
          "id" => @sightseeing.id, 
          "content" => @sightseeing.content,
          "category" => 3, 
          "likes_count" => 0, 
          "dislikes_count" => 0,
          :str_created_at => @sightseeing.created_at.to_s(:db),
          :str_updated_at => @sightseeing.updated_at.to_s(:db),
          :lat => @sightseeing.coordinates.lat,
          :lon => @sightseeing.coordinates.lon, :owner => {
            :username => @owner.username,
            :id => @owner.id
          }}
      end
      
      it "should let him modify the sightseeing tip" do
        @sightseeing.update_with({
          "content" => "A sweety place to visit",
          "category" => Tip.category_for(:categories, :alert)
        }, {"lon" => "-98.13929848000407", "lat" => "20.38650804236533"}, @owner).should be(true)
        
        tip=Tip.find(@sightseeing.id)
        tip.content.should == "A sweety place to visit"
        tip.category.should == 2
        tip.lon.should == -98.13929848000407
        tip.lat.should == 20.38650804236533
      end
    end
  end
  
end