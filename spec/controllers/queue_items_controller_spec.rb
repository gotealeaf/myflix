require 'spec_helper'


describe QueueItemsController do
  let(:user) { Fabricate(:user) }
  let(:video1) { Fabricate(:video) }
  let(:video2) { Fabricate(:video) }
  describe "GET show" do
    context "with authenticated user" do

      let(:item1) { Fabricate(:queue_item, creator: user) }
      let(:item2) { Fabricate(:queue_item, creator: user) }
      before do
        session[:user_id] = user.id
        get :index
      end

      it "assigns @queue_items" do
        expect(assigns(:queue_items)).to match_array([item1, item2])
      end

      it "renders template :index" do
        get :index
        expect(response).to render_template :index
      end
    end

    it "redirects to signin_path with unauthenticated user" do
      get :index
      expect(response).to redirect_to signin_path
    end
  end

  describe "POST create" do
    context "with authenticated user" do
      before { session[:user_id] = user.id }
      context "with valid input" do
        before do
          post :create, video_id: video1.id
          post :create, video_id: video2.id
        end

        it "creates a queue_item" do
          expect(QueueItem.count).to eq(2)
        end
        it "assoicates with user" do
          expect(QueueItem.first.creator).to eq(user)
        end
        it "assoicates with video" do
          expect(QueueItem.first.video).to eq(video1)
        end

        it "pull to last position" do
          expect(QueueItem.last.ranking).to eq(2)
        end

        it "does not add the same video" do
          post :create, video_id: video1.id
          expect(QueueItem.count).to eq(2)
        end
        it "redirects to my_queue_path" do
          expect(response).to redirect_to my_queue_path
        end
      end
    end

    context "with unauthenticated user" do
      it "redirects to signin_path" do
        post :create,  video_id: video1.id
        expect(response).to redirect_to signin_path
      end
    end
  end

  describe "DELETE destroy" do
    context "with anuthenticated user" do
      let(:user) { Fabricate(:user) }
      let(:another_user) { Fabricate(:user) }
      before {  session[:user_id] = user.id }
      let(:queue_item1) { Fabricate(:queue_item, user_id: user.id) }
      before { delete :destroy, id: queue_item1.id }

      it "redirects to my_queue_path" do
        expect(response).to redirect_to my_queue_path
      end

      it "deletes the queue item" do
        expect(QueueItem.count).to eq(0)
      end

      it "does not delete non-current user's queue item" do
        queue_item2 = Fabricate(:queue_item, user_id: another_user.id)

        delete :destroy, id: queue_item2.id
        expect(QueueItem.count).to eq(1)
      end
    end

    context "with unanthenticated user" do
      let(:queue_item) { Fabricate(:queue_item) }
      before { delete :destroy, id: queue_item.id }

      it "redirects to signin_path" do
        expect(response).to redirect_to signin_path
      end
    end
  end
end
