require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "should set the @queue_items instance variable for an authenticated user" do
      jane = Fabricate(:user)
      session[:user_id] = jane.id
      queue_item1 = Fabricate(:queue_item, user: jane)
      queue_item2 = Fabricate(:queue_item, user: jane)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end
    it "should display queue items for authenticated user"
    it "should redirect to root path if user is not authenticated" do
      jane = Fabricate(:user)
      queue_item1 = Fabricate(:queue_item, user: jane)
      queue_item2 = Fabricate(:queue_item, user: jane)
      get :index
      expect(response).to redirect_to root_path
    end
  end
end