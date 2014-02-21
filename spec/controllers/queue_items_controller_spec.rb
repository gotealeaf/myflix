require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do
      amanda = Fabricate(:user)
      set_current_user(amanda)
      queue_item1 = Fabricate(:queue_item, user: amanda)
      queue_item2 = Fabricate(:queue_item, user: amanda)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it_behaves_like "requires sign in" do
      let(:action) {get :index}
    end
  end

  describe "POST create" do
    it "redirects to my queue" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end

    it "creates a queue item" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end

    it "creates a queue item that is associated with the video" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end

    it "creates a queue item that is associated with the signed-in user" do
      amanda = Fabricate(:user)
      set_current_user(amanda)
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(amanda)
    end

    it "puts the video as the last one in the queue" do
      amanda = Fabricate(:user)
      set_current_user(amanda)
      inc = Fabricate(:video)
      Fabricate(:queue_item, video: inc, user: amanda)
      lost = Fabricate(:video)
      post :create, video_id: lost.id
      lost_queue_item = QueueItem.where(video_id: lost.id, user_id: amanda.id).first
      expect(lost_queue_item.position).to eq(2)
    end

    it "does not add the video if it is already in the queue" do
      amanda = Fabricate(:user)
      set_current_user(amanda)
      inc = Fabricate(:video)
      Fabricate(:queue_item, video: inc, user: amanda)
      post :create, video_id: inc.id
      expect(amanda.queue_items.count).to eq(1)
    end

    it_behaves_like "requires sign in" do
      let(:action) { post :create, video_id: 2 }
    end
  end

  describe "DELETE destroy" do
    it "removes the selected queue item from the queue" do
      amanda = Fabricate(:user)
      set_current_user(amanda)
      queue_item = Fabricate(:queue_item, user: amanda)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end

    it "normalizes the remaining queue items" do
      amanda = Fabricate(:user)
      set_current_user(amanda)
      queue_item1 = Fabricate(:queue_item, user: amanda, position: 1)
      queue_item2 = Fabricate(:queue_item, user: amanda, position: 2)
      delete :destroy, id: queue_item1.id
      expect(QueueItem.first.position).to eq(1)
    end

    it "redirects to my queue page" do
      set_current_user
      queue_item = Fabricate(:queue_item)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path
    end

    it "does not delete the queue item if the queue item is not in the current user's queue" do
      amanda = Fabricate(:user)
      bob = Fabricate(:user)
      set_current_user(amanda)
      queue_item = Fabricate(:queue_item, user: bob)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end

    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, id: 3 }
    end
  end

  describe "POST update_queue" do

    it_behaves_like "requires sign in" do
      let(:action) do
        post :update_queue,  queue_items: [{id: 4, position: 2}, {id: 5, position: 1}]
      end
    end

    context "with valid inputs" do

      let(:amanda) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: amanda, position: 1, video: video) }
      let(:queue_item2) { Fabricate(:queue_item, user: amanda, position: 2, video: video) }

      before { set_current_user(amanda) }
      

      it "reorders the queue items" do
        post :update_queue,  queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(amanda.queue_items).to eq([queue_item2, queue_item1])
      end

      it "normalizes the position numbers" do
        post :update_queue,  queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]
        expect(amanda.queue_items.map(&:position)).to eq([1,2])
      end

      it "redirects to my queue" do
        post :update_queue,  queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end
    end

    context "with invalid inputs" do
      
      let(:amanda) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: amanda, position: 1, video: video) }
      let(:queue_item2) { Fabricate(:queue_item, user: amanda, position: 2, video: video) }

      before { set_current_user(amanda) }

      it "redirects to my queue" do
        post :update_queue,  queue_items: [{id: queue_item1.id, position: 2.5}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end

      it "sets the error message" do
        post :update_queue,  queue_items: [{id: queue_item1.id, position: 2.5}, {id: queue_item2.id, position: 1}]
        expect(flash[:danger]).not_to be_blank
      end

      it "does not change the queue items" do
        post :update_queue,  queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1.5}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end
    

    context "with queue items that do not belong to the current user" do
      it "does not change the queue items" do
        amanda = Fabricate(:user)
        bob = Fabricate(:user)
        set_current_user(amanda)
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: bob, position: 1, video: video)
        queue_item2 = Fabricate(:queue_item, user: amanda, position: 2, video: video)
        post :update_queue,  queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 3}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end
  end
end