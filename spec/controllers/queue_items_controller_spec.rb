require 'spec_helper'

describe QueueItemsController do
  before { set_current_user }
  let(:my_video) { Fabricate(:video) }
  let(:alice) { Fabricate(:user) }
  let(:queue_item1) { Fabricate(:queue_item, user: alice, ranking: 1, video: Fabricate(:video)) }
  let(:queue_item2) { Fabricate(:queue_item, user: alice, ranking: 2, video: Fabricate(:video)) }
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do
      set_current_user(alice)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end
    it_behaves_like "require sign in" do
      let(:action) { get :index }
    end
  end
  describe "POST create" do
    it "should create an item in the queue" do
      post :create, video_id: my_video.id
      expect(my_video.queue_items.count).to eq 1
    end
    it "should not add an item to the queue if there's one already there" do
      my_video.queue_items.create(user: current_user, ranking: current_user.queue_items.count + 1)
      post :create, video_id: my_video.id
      expect(my_video.queue_items.count).to eq 1
    end
    it "should be the last item in the queue" do
      other_video = Fabricate(:video)
      other_video.queue_items.create(user: current_user, ranking: current_user.queue_items.count + 1)
      post :create, video_id: my_video.id
      expect(current_user.queue_items.last.video).to eq my_video
    end
    it_behaves_like "require sign in" do
      let(:action) { post :create, video_id: my_video.id }
    end
    it "should not add an item to the queue if not logged in" do
      clear_current_user
      post :create, video_id: my_video.id
      expect(my_video.queue_items.count).to eq 0
    end
    it "should redirect to the queue items page" do
      post :create, video_id: my_video.id
      expect(response).to redirect_to queue_items_path
    end
    it "creates the queue item that is associated with the video" do
      post :create, video_id: my_video.id
      expect(QueueItem.first.video).to eq(my_video)
    end
    it "creates the queue item that is associated with the signed in user" do
      set_current_user(alice)
      post :create, video_id: my_video.id
      expect(my_video.queue_items.first.user).to eq(alice)
    end
    it_behaves_like "require sign in" do
      let(:action) { post :create, video_id: 3 }
    end
  end
  describe "DELETE destroy" do
    it "redirects to the my queue page" do
      delete :destroy, video_id: my_video.id, id: queue_item1.id
      expect(response).to redirect_to queue_items_path
    end
    it "deletes the queue item" do
      set_current_user(alice)
      delete :destroy, video_id: my_video.id, id: queue_item1.id
      expect(QueueItem.count).to eq(0)
    end
    it "renumbers any remaining queue items" do
      set_current_user(alice)
      queue_item2
      delete :destroy, video_id: my_video.id, id: queue_item1.id
      expect(queue_item2.reload.ranking).to eq(1)
    end
    it "does not delete the queue item if the queue item is not in the current user's queue" do
      bob = Fabricate(:user)
      set_current_user(alice)
      queue_item = Fabricate(:queue_item, user: bob)
      delete :destroy, video_id: my_video.id, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end
    it_behaves_like "require sign in" do
      let(:action) { delete :destroy, video_id: my_video.id, id: 3 }
    end
  end
  describe "POST update_queue_list" do
    it_behaves_like "require sign in" do
      let(:action) { post :update_queue_list, queue_items: [{id: queue_item1.id, ranking: queue_item1.ranking}] }
    end
    context "valid data" do
      it "redirects to the My Queue page" do
        set_current_user(alice)
        post :update_queue_list, queue_items: [{id: queue_item1.id, ranking: queue_item1.ranking}]
        expect(response).to redirect_to queue_items_path
      end
      it "reorders the queue items" do
        set_current_user(alice)
        post :update_queue_list, queue_items: [{id: queue_item1.id, ranking: 5}, {id: queue_item2.id, ranking: 2}]
        expect(alice.queue_items).to eq([queue_item2, queue_item1])
      end
      it "resets the ranking in the queue" do
        set_current_user(alice)
        post :update_queue_list, queue_items: [{id: queue_item1.id, ranking: 5}, {id: queue_item2.id, ranking: 2}]
        expect(alice.queue_items.map(&:ranking)).to eq([1,2])
      end
    end
    context "invalid data" do
      it "sets a flash error message for any non-integer value" do
        set_current_user(alice)
        post :update_queue_list, queue_items: [{id: queue_item1.id, ranking: 5.2}, {id: queue_item2.id, ranking: 2}]
        expect(flash[:error]).to be_present
      end
      it "should not make any changes to the queue" do
        set_current_user(alice)
        post :update_queue_list, queue_items: [{id: queue_item1.id, ranking: 5}, {id: queue_item2.id, ranking: 2.8}]
        expect(queue_item1.reload.ranking).to eq(1)
      end
      it "should redirect to the My Queue page" do
        set_current_user(alice)
        post :update_queue_list, queue_items: [{id: queue_item1.id, ranking: 5}, {id: queue_item2.id, ranking: 2.8}]
        expect(response).to redirect_to queue_items_path
      end
    end
    context "not current user" do
      it "doesn't allow the queue items to be changed" do
        set_current_user(alice)
        bob = Fabricate(:user)
        queue_item2 = Fabricate(:queue_item, user: bob, ranking: 2, video: Fabricate(:video))
        post :update_queue_list, queue_items: [{id: queue_item1.id, ranking: 2}, {id: queue_item2.id, ranking: 1}]
        expect(queue_item2.reload.ranking).to eq(2)
      end
    end
  end
end