require "spec_helper"

describe QueueItemsController do
  describe "GET index" do
    context "with authenticated user" do
      before do
        @joe = Fabricate(:user)
        session[:user_id] = @joe.id
      end

      it "displays all of the videos in the user's queue" do
        queue_item1 = Fabricate(:queue_item, user: @joe, position: 1)
        queue_item2 = Fabricate(:queue_item, user: @joe, video_id: 2, position: 2)
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
          @queue_item = Fabricate(:queue_item, video_id: @video.id, user_id: @maria.id, position: 1)
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
        queue_item = Fabricate(:queue_item, user: @jamie, position: 1)
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq(0)
      end

      it "does not delete the queue item if it belongs to another user" do
        jimbo = Fabricate(:user)
        queue_item = Fabricate(:queue_item, user: jimbo, position: 1)
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq(1)
      end

      it "redirects to my queue page" do
        queue_item = Fabricate(:queue_item, position: 1)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to my_queue_path
      end

      it "normalizes the position of the queue items" do
        queue_item1 = Fabricate(:queue_item, position: 1, user: @jamie, video: Fabricate(:video))
        queue_item2 = Fabricate(:queue_item, position: 2, user: @jamie, video: Fabricate(:video))
        queue_item3 = Fabricate(:queue_item, position: 3, user: @jamie, video: Fabricate(:video))
        delete :destroy, id: queue_item1.id
        expect(@jamie.queue_items.map(&:position)).to eq([1,2])
      end
    end

    context "with unauthenticated user" do
      it "redirects to login page" do
        queue_item = Fabricate(:queue_item, position: 1)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "POST update_queue" do
    context "with authenticated user" do
      before do
        @nicole = Fabricate(:user)
        session[:user_id] = @nicole.id
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        @queue_item1 = Fabricate(:queue_item, position: 1, user: @nicole, video: video1)
        @queue_item2 = Fabricate(:queue_item, position: 2, user: @nicole, video: video2)
      end
      context "with valid input" do
        it "redirects to my queue page" do
          post :update_queue, queue_items: [{ id: @queue_item1.id, position: 2 }, { id: @queue_item2, position: 1 }]
          expect(response).to redirect_to my_queue_path
        end
    
        it "updates the order of the queue items" do
          post :update_queue, queue_items: [{ id: @queue_item1.id, position: 2 }, { id: @queue_item2, position: 1 }]
          expect(@nicole.queue_items).to eq([@queue_item2, @queue_item1])
        end

        it "normalizes the position numbers" do
          post :update_queue, queue_items: [{ id: @queue_item1.id, position: 3 }, { id: @queue_item2, position: 2 }]
          expect(@nicole.queue_items.map(&:position)).to eq([1,2])
        end
      end

      context "with invalid input" do
        before { post :update_queue, queue_items: [{ id: @queue_item1.id, position: 3 }, { id: @queue_item2, position: 1.2 }] }

        it "redirects to my queue page" do
           expect(response).to redirect_to my_queue_path
        end

        it "does not change the order of the queue items" do
          expect(@nicole.queue_items).to eq([@queue_item1, @queue_item2])
        end

        it "sends an error message" do
          expect(flash[:error]).to_not be_blank
        end
      end

      context "with queue items that belong to another user" do
        it "does not change the order of the queue_items" do
          jim = Fabricate(:user)
          queue_item1 = Fabricate(:queue_item, user: jim, video: Fabricate(:video), position: 1)
          queue_item2 = Fabricate(:queue_item, user: jim, video: Fabricate(:video), position: 2)
          post :update_queue, queue_items: [{ id: queue_item1.id, position: 2 }, { id: queue_item2, position: 1 }]
          expect(jim.queue_items).to eq([queue_item1, queue_item2])
        end
      end
    end

    context "with unauthenticated user" do
      it "redirects to the login page" do
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        @queue_item1 = Fabricate(:queue_item, position: 1, user: @nicole, video: video1)
        @queue_item2 = Fabricate(:queue_item, position: 2, user: @nicole, video: video2)
        post :update_queue, queue_items: [{ id: @queue_item1.id, position: 2 }, { id: @queue_item2, position: 1 }]
        expect(response).to redirect_to login_path
      end
    end
  end
end




























