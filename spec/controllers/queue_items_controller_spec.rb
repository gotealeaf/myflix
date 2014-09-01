require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    context "for authenticated users" do 

      it "sets @queue_items" do
        karen = Fabricate(:user)
        session[:user_id] = karen.id
        item1 = Fabricate(:queue_item, user: karen)
        item2 = Fabricate(:queue_item, user: karen)
        get :index
        assigns(:queue_items).should match_array([item1, item2])
      end
    end

    context "for unauthenticated users" do 
      it "should redirect to the signin page" do
        get :index
        response.should redirect_to sign_in_path
      end
    end
  end
end