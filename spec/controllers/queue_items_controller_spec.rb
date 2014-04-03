require 'spec_helper'

describe QueueItemsController do
  let(:user) { Fabricate(:user) }

  describe "GET index" do
    it "redirects to sign_in_path with unauthenticated users" do
      get :index
      expect(response).to redirect_to(sign_in_path)
    end

    context "with authenticated users" do
      before :each do
        session[:user_id] = user
        @queue_item_1 = Fabricate(:queue_item, user: user)
        @queue_item_2 = Fabricate(:queue_item, user: user)
        get :index
      end

      it "sets @user" do
        expect(assigns(:user)).to eq user
      end

      it "sets @queue_items" do
        expect(assigns(:queue_items)).to match_array([@queue_item_1, @queue_item_2])
      end

      it "renders the queue template" do
        expect(response).to render_template('users/my_queue')
      end
    end
  end
end