require 'rails_helper.rb'

describe QueueItemsController do
  describe "GET Index" do
    it "sets @queue_items to queue items of logged in user" do
      joe = Fabricate(:user)
      session[:user_id] = joe.id
      queue_item1 = Fabricate(:queue_item, user: joe)
      queue_item2 = Fabricate(:queue_item, user: joe)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end
    it "redirects to sign in page for unauthenticated users" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end
end
