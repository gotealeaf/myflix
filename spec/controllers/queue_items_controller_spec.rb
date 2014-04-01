require 'spec_helper'

describe QueueItemsController do

  describe 'GET index' do
    context "for authenticated (signed in) users" do
      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }

      it "loads the current_user's @queue_items variable" do
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item, video: video, user: current_user)
        get :index
        expect(assigns(:queue_items)).to eq([queue_item])
      end
      it "renders the index page" do
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item, video: video, user: current_user)
        get :index
        expect(response).to render_template :index
      end
    end


    context "for UNauthenticated users (guests)" do
      it "redirects to the signin page" do
        get :index
        expect(response).to redirect_to signin_path
      end
    end


    describe "queue_item.video_title method" do
      it "returns the title for associated video" do
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item, video: video)
        expect(queue_item.video_title).to eq(video.title)
      end
    end

    describe "queue_item.video_categories method" do
      it "returns the categories for associated video" do
        category = Fabricate(:category)
        video = Fabricate(:video, categories: [category])
        queue_item = Fabricate(:queue_item, video: video)
        expect(queue_item.video_categories).to match_array(video.categories)
      end
      it "returns the categories in alphabetical order"
    end

    describe "queue_item.user_rating method" do
      it "returns the rating for associated user's review" do
        user = Fabricate(:user)
        video = Fabricate(:video)
        review = Fabricate(:review, rating: 4, video: video, user: user)
        queue_item = Fabricate(:queue_item, video: video, user: user)
        expect(queue_item.user_rating).to eq(review.rating)
      end
      it "returns nil if there is no review by the user" do
        user = Fabricate(:user)
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item, video: video, user: user)
        expect(queue_item.user_rating).to be_nil
      end
    end
  end
end
