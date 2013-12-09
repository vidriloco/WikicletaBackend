#encoding: utf-8
require 'spec_helper'

describe User do
  
  it "should create a new user when valid params are provided" do
    expect{ 
      User.create_with(FactoryGirl.attributes_for(:user))
    }.to change(User, :count).by(1)
  end
  
  it "should create a new user and a picture when valid params containing a picture are provided" do
    expect{ 
      User.create_with(FactoryGirl.attributes_for(:user).merge(:image_pic => "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJ
      bWFnZVJlYWR5ccllPAAAAA9JREFUeNpiiNIxnA8QYAAC8gFXM+S5IQAAAABJRU5ErkJggg=="))
    }.to change(Picture, :count).by(1)
  end
  
  it "should NOT create a new user when params are missing" do
    User.create_with(:full_name => "Pipo Perengano", :username => "pipo").errors.should_not be_empty
  end
end