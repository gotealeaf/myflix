require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do 
    it "sets @queue_items to the queue items of the logged in user" do 
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      queue1 = Fabricate(:queue_item, user: alice)
      queue2 = Fabricate(:queue_item, user: alice)
      get :index
      expect(assigns(:queue_items)).to match_array([queue1, queue2])
    end 
    it "redirects to the sign in page for unauth users" do 
      get :index
      expect(response).to redirect_to sign_in_path
    end 
  end
end