require 'rails_helper.rb'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to queue items of logged in user" do
      joe = Fabricate(:user)
      set_current_user(joe)
      queue_item1 = Fabricate(:queue_item, user: joe)
      queue_item2 = Fabricate(:queue_item, user: joe)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :index }
    end
  end

  describe "POST create" do
    it "redirects to my queue page" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end
    it "creates the queue item" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end
    it "creates queue item that is associated with the video" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end
    it "creates queue item that is associated with the authenticated user" do
      set_current_user
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user.id).to eq(session[:user_id])
    end
    it "adds video as last in the queue" do
      joe = Fabricate(:user)
      set_current_user(joe)
      futurama = Fabricate(:video)
      Fabricate(:queue_item, user: joe, video: futurama)
      monk = Fabricate(:video)
      post :create, video_id: monk.id
      monk_queue_item = QueueItem.where(video_id: monk.id, user_id: joe.id).first
      expect(monk_queue_item.position).to eq(2)
    end

    it "does not add video to queue if the video is already in queue" do
      joe = Fabricate(:user)
      set_current_user(joe)
      futurama = Fabricate(:video)
      Fabricate(:queue_item, user: joe, video: futurama)
      post :create, video_id: futurama.id
      expect(QueueItem.count).to eq(1)
    end

    it_behaves_like "requires sign in" do
      let(:action) { post :create, video_id: 1 }
    end
  end

  describe "DELETE destroy" do
    it "redirects to my queue page" do
      set_current_user
      item = Fabricate(:queue_item)
      delete :destroy, id: item.id
      expect(response).to redirect_to my_queue_path
    end

    it "deletes queue item from queue" do
      joe = Fabricate(:user)
      set_current_user(joe)
      item = Fabricate(:queue_item, user: joe)
      delete :destroy, id: item.id
      expect(QueueItem.count).to eq(0)
    end

    it "normalizes remaining queue items" do
      joe = Fabricate(:user)
      set_current_user(joe)
      queue_item1 = Fabricate(:queue_item, user: joe, position: 1)
      queue_item2 = Fabricate(:queue_item, user: joe, position: 2)
      delete :destroy, id: queue_item1.id
      expect(QueueItem.first.position).to eq(1)
    end

    it "does not delete queue item if not in current user's queue" do
      joe = Fabricate(:user)
      set_current_user(joe)
      bob = Fabricate(:user)
      item = Fabricate(:queue_item, user: bob)
      delete :destroy, id: item.id
      expect(QueueItem.count).to eq(1)
    end

    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, id: 1 }
    end
  end

  describe "POST update_queue" do
    it_behaves_like "requires sign in" do
      let(:action) do
        post :update_queue, queue_items: [{id: 1, position: 1}, {id: 2, position: 2}]
      end
    end

    context "valid inputs" do

      let(:joe) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: joe, video: video, position: 1) }
      let(:queue_item2) { Fabricate(:queue_item, user: joe, video: video, position: 2) }

      before do
        set_current_user(joe)
      end

      it "redirects to my queue page" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end

      it "re-orders the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(joe.queue_items).to eq([queue_item2, queue_item1])
      end

      it "normalizes the position numbers" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 5}]
        expect(joe.queue_items.map(&:position)).to eq([1, 2])
=begin
Alternate method, note reload required because of local variables in controller not updating local variables in spec. joe.queue_items actually hits DB.
        expect(queue_item1.reload.position).to eq(1)
        expect(queue_item2.reload.position).to eq(2)
=end
      end
    end

    context "invalid inputs" do

      let(:joe) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: joe, video: video, position: 1) }
      let(:queue_item2) { Fabricate(:queue_item, user: joe, video: video, position: 2) }

      before do
        set_current_user(joe)
      end

      it "redirects to my queue page" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.8}, {id: queue_item2.id, position: 5}]
        expect(response).to redirect_to my_queue_path
      end

      it "sets flash error message" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.8}, {id: queue_item2.id, position: 5}]
        expect(flash[:danger]).to be_present
      end

      it "does not update queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 4.8}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end

    context "queue items that do not belong to current user" do
      it "does not update queue items" do
        joe = Fabricate(:user)
        set_current_user(joe)
        bob = Fabricate(:user)
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: joe, video: video, position: 1)
        queue_item2 = Fabricate(:queue_item, user: bob, video: video, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 3}]
        expect(queue_item2.reload.position).to eq(2)
      end
    end
  end

end
