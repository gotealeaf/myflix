require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do
      sam = Fabricate(:user)
      session[:user_id] = sam.id
      queue_item1 = Fabricate(:queue_item, user: sam)
      queue_item2 = Fabricate(:queue_item, user: sam)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end
    it "redirect to the sign in page for unauthenticated user" do
      get :index 
      expect(response).to redirect_to sign_in_path
    end
  end
end
