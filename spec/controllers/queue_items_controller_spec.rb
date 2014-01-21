require 'spec_helper'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do
      sam = Fabricate(:user)
      session[:user_id] = sam.id
      queue_item1 = Fabricate(:queue_item, user: sam)
      queue_item2 = Fabricate(:queue_item, user: sam)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end
    it "redirect to the sign in page for unauthenticated user" do
      get :index 
      expect(response).to redirect_to sign_in_path
    end
  end


  describe "POST create" do
    it "reirects to the my queue page" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end

    it "creawtes a queue item" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end

    it "create the queue that is associated with the video" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end

    it "create the queue item that is associated with the sign in user" do
      sam = Fabricate(:user)
      session[:user_id] = sam.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.first.user).to eq(sam)
    end

    it "pusts the video as the last one in queue" do
      sam = Fabricate(:user)
      session[:user_id] = sam.id 
      toy = Fabricate(:video)
      Fabricate(:queue_item, video: toy, user: sam)
      kungfu = Fabricate(:video)
      post :create, video_id: kungfu.id 
      kungfu_queue_item = QueueItem.where(video_id: kungfu.id, user_id: sam.id).first
      expect(kungfu_queue_item.position).to eq(2)
    end

    it "does not add the video  if the video is already in the queue" do
      sam = Fabricate(:user)
      session[:user_id] = sam.id 
      toy = Fabricate(:video)
      Fabricate(:queue_item, video: toy, user: sam)
      post :create, video_id: toy.id 
      expect(sam.queue_items.count).to eq(1)
    end

    it "redirect to the sign in page if unauthenticated user" do
      post :create, video_id: 3
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "DELETE destroy" do
    it "redirects to the my queue page" do
      session[:user_id] = Fabricate(:user).id
      queue_item = Fabricate(:queue_item)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path
    end

    it "deletes the queue item" do
      sam = Fabricate(:user)
      session[:user_id] = sam.id
      queue_item = Fabricate(:queue_item, user: sam)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end
    
    it "does not delete the queue item if the queue item is not in the cuurent user's queue" do
      sam = Fabricate(:user)
      vivian = Fabricate(:user)
      session[:user_id] = sam.id
      queue_item = Fabricate(:queue_item, user: vivian)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end

    it "redirects to the sign in page for unauthenticated user" do
      delete :destroy, id: 3
      expect(response).to redirect_to sign_in_path
    end

    it "normalizes the remaining queue items" do
      sam = Fabricate(:user)
      session[:user_id] = sam.id
      queue_item1 = Fabricate(:queue_item, user: sam, position: 1)
      queue_item2 = Fabricate(:queue_item, user: sam, position: 1)
      delete :destroy, id: queue_item1.id
      expect(QueueItem.first.position).to eq(1)
    end
  end

  describe "POST update_queue" do
    context "with valid inputs" do

      let(:sam) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: sam, position: 1, video: video) }
      let(:queue_item2) { Fabricate(:queue_item, user: sam, position: 2, video: video) }

      before do
        session[:user_id] = sam.id
      end

      it "redirect to my queue page" do
        post :update_queue, queue_items: [{ id: queue_item1.id, position: 2 }, { id: queue_item2, positon: 1 }] 
        expect(response).to redirect_to my_queue_path
      end

      it "reorder the queue item" do
        post :update_queue, queue_items: [{ id: queue_item1.id, position: 2 }, { id: queue_item2.id, position: 1 }] 
        expect(sam.queue_items).to eq([queue_item2, queue_item1])
      end
      it "normalizes the positon numbers" do
        post :update_queue, queue_items: [{ id: queue_item1.id, position: 3 }, { id: queue_item2.id, position: 2 }] 
        expect(sam.queue_items.map(&:position)).to eq([1, 2]) 
      end
    end

    context "with invalid inputs" do
      
      let(:sam) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: sam, position: 1, video: video) }
      let(:queue_item2) { Fabricate(:queue_item, user: sam, position: 2, video: video) }

      before do
        session[:user_id] = sam.id
      end

      it "redirect to the my queue page" do
        post :update_queue, queue_items: [{ id: queue_item1.id, position: 3.3 }, { id: queue_item2.id, position: 2 }] 
        expect(response).to redirect_to my_queue_path
      end

      it "set the flash error message" do
        post :update_queue, queue_items: [{ id: queue_item1.id, position: 3.3 }, { id: queue_item2.id, position: 2 }] 
        expect(flash[:error]).to be_present
      end

      it "does not change the queue items" do
        post :update_queue, queue_items: [{ id: queue_item1.id, position: 3 }, { id: queue_item2.id, position: 2.1 }] 
        expect(queue_item1.reload.position).to eq(1)
      end
    end

    context "with unauthenticated user" do
      it "redirect to the sign in path" do
        post :update_queue, queue_items: [{ id: 1, position: 3 }, { id: 2, position: 2.1 }] 
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with queue itmes that not belongs to current user" do
      it "does not change the queue items" do
        sam = Fabricate(:user)
        session[:user_id] = sam.id
        vivian = Fabricate(:user)
        video = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: vivian, position: 1, video: video)
        queue_item2 = Fabricate(:queue_item, user: sam, position: 2, video: video)
        post :update_queue, queue_items: [{ id: queue_item1.id, position: 3 }, { id: queue_item2.id, position: 2.1 }] 
        expect(queue_item1.reload.position).to eq(1)
      end
    end
  end

  describe "#rating=" do
   
    subject { Review.first.rate }
    let(:video) { Fabricate(:video) }
    let(:user) { Fabricate(:user) }
    let(:review) { Fabricate(:review, user: user, video: video, rate: 2) }
    let(:queue_item) { Fabricate(:queue_item, user: user, video: video) }

    it "changes the rating of the review if the review is present" do
      queue_item.rating = 4
      expect(subject).to eq(4)
    end

    it "clears the rating of the review if the review is present" do
      queue_item.rating = nil
      expect(subject).to be_nil
    end

    it "creates a review with the rating if the review is not present" do
      queue_item.rating = 3 
      expect(subject).to eq(3)
    end
  end
end
