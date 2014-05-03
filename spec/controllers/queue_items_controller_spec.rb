require 'spec_helper'

describe QueueItemsController do
  
  describe "GET index" do
    
    let(:jane) { Fabricate(:user) } 
    let(:queue_item1) { Fabricate(:queue_item, user: jane) }
    let(:queue_item2) { Fabricate(:queue_item, user: jane) }
    
    it "should set the @queue_items instance variable for an authenticated user" do
      session[:user_id] = jane.id
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it "should redirect to root path if user is not authenticated" do
      get :index
      expect(response).to redirect_to root_path
    end
  end
end