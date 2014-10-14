require 'spec_helper'

describe QueueItemsController do
  
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do
      darren = Fabricate(:user)
      session[:user_id] = darren.id
      queue_item1 = Fabricate(:queue_item, user: darren)
      queue_item2 = Fabricate(:queue_item, user: darren)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end
    it "redirects to the sign-in page for unauthenticated users" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end
  
end