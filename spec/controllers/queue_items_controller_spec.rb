require 'spec_helper'

describe QueueItemsController do

  describe 'GET index' do
    context "for authenticated (signed in) users" do
      let(:current_user) { Fabricate(:user) }
      let(:video)        { Fabricate(:video) }
      let(:queue_item)   { Fabricate(:queue_item, video: video, user: current_user) }

      before do
        session[:user_id] = current_user.id
        get :index
      end

      it "loads the current_user's @queue_items variable" do
        expect(assigns(:queue_items)).to eq([queue_item])
      end
      it "renders the index page" do
        expect(response).to render_template :index
      end
    end


    context "for UNauthenticated users (guests)" do
      it "redirects to the signin page" do
        get :index
        expect(response).to redirect_to signin_path
      end
    end
  end
end
