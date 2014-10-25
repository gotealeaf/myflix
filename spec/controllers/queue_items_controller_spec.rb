require 'spec_helper'

describe QueueItemsController do
  
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do
      set_current_user
      queue_item1 = Fabricate(:queue_item, user: current_user)
      queue_item2 = Fabricate(:queue_item, user: current_user)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end
    it_behaves_like "require_sign_in" do
      let(:action) {get :index}
    end
  end
  
  describe "POST create" do
    before { set_current_user }
    it "redirects to the my_queue page" do
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end
    it "creates a new queue_item object" do
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end
    it "associates the queue_item with the video" do
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end
    it "associates the queue_item with the signed-in user" do
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(current_user)
    end
    it "puts the video as the last one in the que" do 
      video1 = Fabricate(:video)
      Fabricate(:queue_item, video: video1, user: current_user)
      video2 = Fabricate(:video)
      post :create, video_id: video2.id
      video2_queue_item = QueueItem.where(video_id: video2.id, user_id: current_user.id).first
      expect(video2_queue_item.position).to eq(2)
    end
    it "does not add the video to the queue if it is already there" do
      video1 = Fabricate(:video)
      Fabricate(:queue_item, video: video1, user: current_user)
      post :create, video_id: video1.id
      expect(current_user.queue_items.count).to eq(1)
    end
    it_behaves_like "require_sign_in" do
      let(:action) {post :index, video_id: 3}
    end
  end
  
  describe "POST update_queue" do
    before { set_current_user }
    it_behaves_like "require_sign_in" do
      let(:action) {post :update_queue, queue_items: [{id: 1, position: 3}, {id: 2, position: 1}]}
    end
    it "does not make any modifications to the queue items that do not belong to the current user" do
      larissa = Fabricate(:user)
      queue_item1 = Fabricate(:queue_item, user: larissa, position: 1)
      queue_item2 = Fabricate(:queue_item, user: larissa, position: 2)
      post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 1}]
      expect(queue_item1.reload.position).to eq(1)
    end
    context "with valid inputs" do
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: current_user, position: 1, video: video) }
      let(:queue_item2) { Fabricate(:queue_item, user: current_user, position: 2, video: video) }
      it "redirects to the my_queue page" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end
      it "reorders the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(current_user.queue_items).to eq([queue_item2, queue_item1])
      end
      it "normalizes the position numbers" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]
        expect(current_user.queue_items.map(&:position)).to eq([1, 2])
      end 
    end
    context "with invalid inputs" do
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: current_user, position: 1, video: video) }
      let(:queue_item2) { Fabricate(:queue_item, user: current_user, position: 2, video: video) }
      it "redirects to the my_queue page" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.4}, {id: queue_item2.id, position: 2}]
        expect(response).to redirect_to my_queue_path
      end
      it "sets the flash error message" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.4}, {id: queue_item2.id, position: 2}]
        expect(flash[:error]).to be_present
      end
      it "does not make any modifications to the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2.1}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end
  end
  
  describe "DELETE destroy" do
    before { set_current_user }
    it "redirects to my_queue_path" do
      item = Fabricate(:queue_item)
      delete :destroy, id: item.id
      expect(response).to redirect_to my_queue_path
    end
    it "deletes the queue_item" do
      item = Fabricate(:queue_item, user_id: current_user.id)
      delete :destroy, id: item.id
      expect(QueueItem.count).to eq(0)
    end
    it "normalizes the remaining queue items if one is deleted" do
      queue_item1 = Fabricate(:queue_item, user: current_user, position: 1)
      queue_item2 = Fabricate(:queue_item, user: current_user, position: 2)
      queue_item3 = Fabricate(:queue_item, user: current_user, position: 3)
      delete :destroy, id: queue_item1.id
      expect(current_user.queue_items.map(&:position)).to eq([1,2])
    end
    it "does not delete the queue item if it is not in the current_user's queue" do
      larissa = Fabricate(:user)
      item = Fabricate(:queue_item, user_id: larissa.id)
      delete :destroy, id: item.id
      expect(QueueItem.count).to eq(1)
    end
    it_behaves_like "require_sign_in" do
      let(:action) {delete :destroy, id: 2}
    end
  end
end