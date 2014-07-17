require "spec_helper"

describe QueueItemsController do
  describe "GET index" do
    before { set_current_user } 

    context "with authenticated user" do
      before { get :index }

      it "displays all of the videos in the user's queue" do
        queue_item1 = Fabricate(:queue_item, user: current_user, position: 1)
        queue_item2 = Fabricate(:queue_item, user: current_user, video_id: 2, position: 2)
        expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
      end

      it "renders the :index template" do
        expect(response).to render_template :index
      end
    end

    it_behaves_like "require_login" do
      let(:action) { get :index }
    end
  end

  describe "POST create" do
    let (:video) { Fabricate(:video) }
    before { set_current_user }

    context "with an authenticated user" do
      context "if video is not already in the queue"
        before do
          post :create, video_id: video.id, user_id: current_user.id
        end

        it "creates a new queue item" do
          expect(QueueItem.count).to be(1)
        end

        it "creates a new queue item associated with video" do
          expect(QueueItem.first.video).to eq(video)
        end

        it "creates a new queue item associated with the logged in user" do
          expect(QueueItem.first.user).to eq(current_user)
        end

        it "sets the video as the last in the queue" do
          monk = Fabricate(:video)
          post :create, video_id: monk.id, user_id: current_user.id
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
        let(:video2) { Fabricate(:video) }
        before do
          queue_item = Fabricate(:queue_item, video_id: video2.id, user_id: current_user.id, position: 1)
          post :create, video_id: video2.id, user_id: current_user.id
        end

        it "does not create a new queue item" do
          expect(current_user.queue_items.count).to be(2)
        end

        it "sends the notice" do
          expect(flash[:error]).to_not be_blank
        end

        it "renders the video show template" do
          expect(response).to redirect_to video_path(video2)
        end
      end
    end

    it_behaves_like "require_login" do
      let(:action) { post :create, video_id: video.id }
    end
  end 

  describe "DELETE destroy" do
    before { set_current_user }

    context "with authenticated user" do
      let(:queue_item) { Fabricate(:queue_item, user: current_user, position: 1) }
      
      it "deletes the selected queue item" do 
        delete :destroy, id: queue_item.id 
        expect(QueueItem.count).to eq(0)
      end

      it "does not delete the queue item if it belongs to another user" do
        jimbo = Fabricate(:user)
        queue_item = Fabricate(:queue_item, user: jimbo, position: 1)
        delete :destroy, id: queue_item.id
        expect(jimbo.queue_items.count).to eq(1)
      end

      it "redirects to my queue page" do
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to my_queue_path
      end

      it "normalizes the position of the queue items" do
        queue_item2 = Fabricate(:queue_item, position: 2, user: current_user, video: Fabricate(:video))
        queue_item3 = Fabricate(:queue_item, position: 3, user: current_user, video: Fabricate(:video))
        delete :destroy, id: queue_item.id
        expect(current_user.queue_items.map(&:position)).to eq([1, 2])
      end
    end

    it_behaves_like "require_login" do
      let(:action) { delete :destroy, id: Fabricate(:queue_item).id }
    end
  end

  describe "POST update_queue" do
    before { set_current_user }

    context "with authenticated user" do
      before do
        video1 = Fabricate(:video)
        video2 = Fabricate(:video)
        @queue_item1 = Fabricate(:queue_item, position: 1, user: current_user, video: video1)
        @queue_item2 = Fabricate(:queue_item, position: 2, user: current_user, video: video2)
      end

      context "with valid input" do
        it "redirects to my queue page" do
          post :update_queue, queue_items: [{ id: @queue_item1.id, position: 2 }, { id: @queue_item2, position: 1 }]
          expect(response).to redirect_to my_queue_path
        end
    
        it "updates the order of the queue items" do
          post :update_queue, queue_items: [{ id: @queue_item1.id, position: 2 }, { id: @queue_item2, position: 1 }]
          expect(current_user.queue_items).to eq([@queue_item2, @queue_item1])
        end

        it "normalizes the position numbers" do
          post :update_queue, queue_items: [{ id: @queue_item1.id, position: 3 }, { id: @queue_item2, position: 2 }]
          expect(current_user.queue_items.map(&:position)).to eq([1,2])
        end
      end

      context "with invalid input" do
        before { post :update_queue, queue_items: [{ id: @queue_item1.id, position: 3 }, { id: @queue_item2, position: 1.2 }] }

        it "redirects to my queue page" do
           expect(response).to redirect_to my_queue_path
        end

        it "does not change the order of the queue items" do
          expect(current_user.queue_items).to eq([@queue_item1, @queue_item2])
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

    it_behaves_like "require_login" do
      let(:action) { post :update_queue, queue_items: [{ id: Fabricate(:queue_item, video: Fabricate(:video)).id }] }
    end
  end
end




























