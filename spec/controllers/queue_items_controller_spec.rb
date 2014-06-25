require "spec_helper"

describe QueueItemsController do
  describe "GET index" do
    context "with authenticated user" do
      before do
        @joe = Fabricate(:user)
        session[:user_id] = @joe.id
      end

      it "displays all of the videos in the user's queue" do
        queue_item1 = Fabricate(:queue_item, user: @joe)
        queue_item2 = Fabricate(:queue_item, user: @joe, video_id: 2)
        get :index
        expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    context "with unauthenticated user" do
      it "redirects to login page" do
        get :index
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "POST create" do
    context "with an authenticated user" do
      before(:each) do
        @maria = Fabricate(:user)
        session[:user_id] = @maria.id
      end

      context "if video is not already in the queue"
        before(:each) do
          @video = Fabricate(:video)
          post :create, video_id: @video.id, user_id: @maria.id
        end

        it "creates a new queue item" do
          expect(QueueItem.count).to be(1)
        end

        it "creates a new queue item associated with video" do
          expect(QueueItem.first.video).to eq(@video)
        end

        it "creates a new queue item associated with the logged in user" do
          expect(QueueItem.first.user).to eq(@maria)
        end

        it "sets the video as the last in the queue" do
          monk = Fabricate(:video)
          post :create, video_id: monk.id, user_id: @maria.id
          queue_item = QueueItem.last
          expect(queue_item.position).to eq(2)
        end

        it "sends the notice" do
          expect(flash[:notice]).to_not be_blank
        end

        it "redirects to my queue path" do
          expect(response).to redirect_to my_queue_path
        end

      context "if the video is already in queue" do
        before do
          @video = Fabricate(:video)
          @queue_item = Fabricate(:queue_item, video_id: @video.id, user_id: @maria.id )
          post :create, video_id: @video.id, user_id: @maria.id
        end

        it "does not create a new queue item" do
          expect(@maria.queue_items.count).to be(2)
        end

        it "sends the notice" do
          expect(flash[:error]).to_not be_blank
        end

        it "renders the video show template" do
          expect(response).to redirect_to video_path(@video)
        end
      end
    end
  end
  context "with unauthenticated user" do
    it "redirects to login page" do
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to login_path
    end
  end

  describe "DELETE destroy" do
    context "with authenticated user" do
      before do
        @jamie = Fabricate(:user)
        session[:user_id] = @jamie.id
      end

      it "deletes the selected queue item" do
        queue_item = Fabricate(:queue_item, user: @jamie)
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq(0)
      end

      it "does not delete the queue item if it belongs to another user" do
        jimbo = Fabricate(:user)
        queue_item = Fabricate(:queue_item, user: jimbo)
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq(1)
      end

      it "redirects to my queue page" do
        queue_item = Fabricate(:queue_item)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to my_queue_path
      end
    end

    context "with unauthenticated user" do
      it "redirects to login page" do
        queue_item = Fabricate(:queue_item)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to login_path
      end
    end
  end
end



























