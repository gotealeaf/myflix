require 'rails_helper'

describe QueueItemsController do
  
  context "signed in users" do
  
    describe "GET index" do
      let(:user) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      before do
        cookies[:auth_token] = user.auth_token
      end
      
      it "should assign the @queue_items variable for the signed in user" do
        qitem = Fabricate(:queue_item, video: video, user: user)
        qitem2 = Fabricate(:queue_item, video: video, user: user)
        get :index
        expect(assigns(:queue_items)).to match_array([qitem,qitem2])
      end

    end
  
  end
  
  context "users who are NOT signed in" do
    describe "GET index" do
      it "should redirect to the sign_in page" do
        get :index
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end
  
end