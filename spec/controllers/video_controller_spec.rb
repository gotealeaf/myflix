require 'spec_helper'

describe "VideoController" do
  let(:video) { Video.create(name: "futurama", description: "funny movie", id: 1 }
  
  describe "GET Show" do
    it "should render the show page if params can be found" do
      get :show
      response.should render_template :show
    end
      
    it "should find the right id param" do
      get :show
      Video.first.id.should == 1
    end
    
  end
  
  describe "GET Search" do
    
    it "should return the search results if there is a partial match to title param" do
      get :search
      Video.search_by_title("futura").should == futurama
    end
    
    it "should return zero results if title params do not match" do
      get :search
      Video.search_by_title("Robocop").should == ""
    end
    
    it "should return one exact result if param matches exactly" do
      get :search
      Video.search_by_title("futurama").should == futurama
    end
    
    it "should return all the related results if partial params match"
    
    it "should return the search page to the user" do
      get :search
      response.should render_template :search
    end
    
  end
 end