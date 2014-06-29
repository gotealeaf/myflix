require "rails_helper"

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue items of the current user" do
      dan = Fabricate(:user)
      set_current_user(dan)
      queue_item1 = Fabricate(:queue_item, user: dan)
      queue_item2 = Fabricate(:queue_item, user: dan)

      get :index

      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it_behaves_like "require sign in" do
      let(:action) { get :index }
    end
  end #GET index

  describe "POST create" do
    it "redirects to the my queue page" do
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

    it "creates a queue item associated with the current video" do
      set_current_user
      video = Fabricate(:video)

      post :create, video_id: video.id

      expect(QueueItem.first.video).to eq(video)
    end

    it "creates a queue item assocaited with the current user" do
      condor = Fabricate(:user)
      set_current_user(condor)
      video = Fabricate(:video)

      post :create, video_id: video.id

      expect(QueueItem.first.user).to eq(condor)
    end

    it "adds the video at the end of the queue" do
      condor = Fabricate(:user)
      set_current_user(condor)
      existing_video = Fabricate(:video)
      Fabricate(:queue_item, user: condor, video: existing_video)
      newly_added_video = Fabricate(:video)

      post :create, video_id: newly_added_video.id
      new_queue_item = QueueItem.where(video_id: newly_added_video.id, user_id: condor.id).first

      expect(new_queue_item.position).to eq(2)
    end

    it "does not add the video to the queue if that video is already present" do
      condor = Fabricate(:user)
      set_current_user(condor)
      existing_video = Fabricate(:video)
      Fabricate(:queue_item, user: condor, video: existing_video)

      post :create, video_id: existing_video.id
      new_queue_item = QueueItem.where(video_id: existing_video.id, user_id: condor.id).first

      expect(condor.queue_items.count).to eq(1)
    end

    it_behaves_like "require sign in" do
      let(:action) { post :create, video_id: 3 }
    end
  end #POST create

  describe "DELETE destroy" do
    it "redirects to the my queue page" do
      set_current_user
      queue_item = Fabricate(:queue_item)
      
      delete :destroy, id: queue_item.id

      expect(response).to redirect_to my_queue_path
    end

    it "deletes the queue item" do
      taren = Fabricate(:user)
      set_current_user(taren)
      queue_item = Fabricate(:queue_item, user: taren)
      
      delete :destroy, id: queue_item.id

      expect(QueueItem.count).to eq(0)
    end

    it "normalizes the remaining queue items" do
      taren = Fabricate(:user)
      set_current_user(taren)
      queue_item1 = Fabricate(:queue_item, user: taren, position: 1)
      queue_item2 = Fabricate(:queue_item, user: taren, position: 2)

      delete :destroy, id: queue_item1.id

      expect(QueueItem.first.position).to eq(1)
    end

    it "does not delete the queue item if the queue item is not in the current user's queue" do
      taren = Fabricate(:user)
      cullen = Fabricate(:user)
      set_current_user(taren)
      queue_item = Fabricate(:queue_item, user: cullen)

      delete :destroy, id: queue_item.id

      expect(QueueItem.count).to eq(1)
    end

    it_behaves_like "require sign in" do
      let(:action) { delete :destroy, id: 3 }
    end
  end #DELETE destroy

  describe "POST update_queue" do
    it_behaves_like "require sign in" do
      let(:action) { post :update_queue, queue_items: [{ id: 1, position: 1 }] }
    end

    context "with valid inputs" do
      let(:alice) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: alice, video: video, position: 1) }
      let(:queue_item2) { Fabricate(:queue_item, user: alice, video: video, position: 2) }
      
      before { set_current_user(alice) }

      it "redirects to the my queue page" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, 
                                          {id: queue_item2.id, position: 1}]

        expect(response).to redirect_to my_queue_path
      end           

      it "reorders the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, 
                                          {id: queue_item2.id, position: 1}]

        expect(alice.queue_items).to eq([queue_item2, queue_item1])
      end

      it "normalizes the position numbers" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, 
                                          {id: queue_item2.id, position: 2}]

        # expect(queue_item1.reload.position).to eq(2)
        # expect(queue_item2.reload.position).to eq(1)
        expect(alice.queue_items.map(&:position)).to eq([1, 2])
      end
    end

    context "with invalid inputs" do
      let(:alice) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: alice, video: video, position: 1) }
      let(:queue_item2) { Fabricate(:queue_item, user: alice, video: video, position: 2) }
      
      before { set_current_user(alice) }

      it "redirects to the my queue page" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2.7}, 
                                          {id: queue_item2.id, position: 1}]

        expect(response).to redirect_to my_queue_path
      end

      it "sets the flash error message" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2.7}, 
                                          {id: queue_item2.id, position: 1}]

        expect(flash[:danger]).to be_present
      end

      it "does not change the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, 
                                          {id: queue_item2.id, position: 2.4}]

        expect(queue_item1.reload.position).to eq(1)
      end
    end

    context "with queue items that do not belong to the current user" do
      it "does not change the queue items" do
        alice = Fabricate(:user)
        kevin = Fabricate(:user)
        set_current_user(alice)
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: kevin, video: video, position: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, video: video, position: 2)

        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, 
                                          {id: queue_item2.id, position: 1}]

        expect(queue_item1.reload.position).to eq(1)
      end
    end
  end #POST update_queue
end