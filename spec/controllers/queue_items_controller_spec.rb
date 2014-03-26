require 'spec_helper'
require 'pry'

describe QueueItemsController do
  describe "GET index" do
    context "when user is authenticated" do
      it "sets the @queue_items variable" do
        current_user = Fabricate(:user)
        session[:user_id] = current_user.id
        queue_item1 = Fabricate(:queue_item, user: current_user)
        queue_item2 = Fabricate(:queue_item, user: current_user)

        get :index
        expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
      end
    end

    it_behaves_like "require_sign_in" do
      let(:action) { post :index }
    end
  end

  describe "POST create" do
    it "redirects to the my que page" do
      current_user = Fabricate(:user)
      session[:user_id] = current_user.id
      video = Fabricate(:video)

      post :create
      expect(response).to redirect_to(queue_items_path)
    end

    it "creates a queue item" do
      current_user = Fabricate(:user)
      session[:user_id] = current_user.id
      video = Fabricate(:video)

      post :create
      expect(QueueItem.count).to eq(1)
    end

    it "creates the que item that is associated with the video" do
      current_user = Fabricate(:user)
      session[:user_id] = current_user.id
      video = Fabricate(:video)

      post :create, queue_item: { video_id: video.id }, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end

    it "creates the que item that is associated with the signed in user" do
      current_user = Fabricate(:user)
      session[:user_id] = current_user.id
      video = Fabricate(:video)

      post :create, queue_item: { video_id: video.id, user_id: current_user.id }, video_id: video.id, user_id: current_user
      expect(QueueItem.first.user).to eq(current_user)
    end

    it "puts the video as the last one in the que" do
      current_user = Fabricate(:user)
      session[:user_id] = current_user.id
      south_park = Fabricate(:video)
      family_guy = Fabricate(:video)
      que2 = Fabricate(:queue_item, video_id: family_guy.id, user_id: current_user.id)
      que1 = Fabricate(:queue_item, video_id: south_park.id, user_id: current_user.id)

      expect(current_user.queue_items.to_a).to match_array([que2, que1])
    end

    it "does not add the video to the que if the video is already in the que" do
      current_user = Fabricate(:user)
      session[:user_id] = current_user.id
      south_park = Fabricate(:video)
      family_guy = Fabricate(:video)
      queue1 = Fabricate(:queue_item, video: south_park, user: current_user)
      queue2 = Fabricate(:queue_item, video: family_guy, user: current_user)
      
      post :create, queue_item: { video: south_park, user: current_user }, video_id: south_park.id, user_id: current_user.id
      expect(current_user.queue_items.count).to eq(2)
    end

    it "redirects to the sign in page for unauthenticated users" do
      current_user = Fabricate(:user)
      south_park = Fabricate(:video)
      
      post :create, queue_item: { video_id: south_park.id, user_id: current_user.id }, video_id: south_park.id, user_id: current_user.id
      expect(response).to redirect_to(sign_in_path)
    end
  end


  describe "DELETE destroy" do
    it "redirects to the my queue page" do
      current_user = Fabricate(:user)
      session[:user_id] = current_user.id
      q1 = Fabricate(:queue_item, user: current_user)

      delete :destroy, id: q1.id
      expect(response).to redirect_to(queue_items_path)

    end

    it "removes a queue item from the current user's que page" do
      current_user = Fabricate(:user)
      session[:user_id] = current_user.id
      q1 = Fabricate(:queue_item, user: current_user)

      delete :destroy, id: q1.id
      expect(QueueItem.count).to eq(0)
    end

    it "normalizes remaining queue items after deletion of an item" do
      current_user = Fabricate(:user)
      session[:user_id] = current_user.id
      q1 = Fabricate(:queue_item, user: current_user, position: 1)
      q2 = Fabricate(:queue_item, user: current_user, position: 2)
      q3 = Fabricate(:queue_item, user: current_user, position: 3)

      delete :destroy, id: q2.id
      expect(current_user.queue_items.map(&:position)).to eq([1, 2])
    end

    it "does not delete the queue item if the current user does not own the queue item" do
      bob = Fabricate(:user)
      jane = Fabricate(:user)
      session[:user_id] = bob.id
      q1 = Fabricate(:queue_item, user: jane)

      delete :destroy, id: q1.id
      expect(QueueItem.count).to eq(1)
    end
    
    it "redirects to the sign in page if the user is unauthenticated" do
      q1 = Fabricate(:queue_item)
      delete :destroy, id: q1.id
      expect(response).to redirect_to(sign_in_path)
    end
  end

  describe "POST sort" do
    context "with valid inputs" do

      let(:current_user) { Fabricate(:user)}
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: current_user, position: 1, video: video) }
      let(:queue_item2) { Fabricate(:queue_item, user: current_user, position: 2, video: video) }
      let(:queue_item3) { Fabricate(:queue_item, user: current_user, position: 3, video: video) }

      before do
        session[:user_id] = current_user.id
      end

      it "redirects to the queue items page" do
        post :sort, queue_items: [{id: queue_item1.id, position: 1}, {id: queue_item2.id, position: 2}]
        expect(response).to redirect_to(queue_items_path)
      end

      it "re orders each item by position number" do        
        post :sort, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(current_user.queue_items).to eq([queue_item2, queue_item1])
      end

      it "normalizes the position numbers" do
        post :sort, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 4}, {id: queue_item3.id, position: 1}]
        expect(current_user.queue_items.map(&:position)).to eq([1, 2, 3])
      end
    end
    context "with invalid inputs" do
      let(:current_user) { Fabricate(:user)}
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: current_user, position: 1, video: video) }
      let(:queue_item2) { Fabricate(:queue_item, user: current_user, position: 2, video: video) }
      let(:queue_item3) { Fabricate(:queue_item, user: current_user, position: 3, video: video) }

      before do
        session[:user_id] = current_user.id
      end

      it "redirects to the queue items page" do
        post :sort, queue_items: [{id: queue_item1.id, position: 2.5}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to(queue_items_path)
      end

      it "sets the flash error message" do      
        post :sort, queue_items: [{id: queue_item1.id, position: 2.5}, {id: queue_item2.id, position: 1}]
        expect(flash[:notice]).to eq("Please only use whole numbers to update the queue")
      end

      it "does not reorder the queue items" do
        post :sort, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2.1}]
        expect(queue_item1.reload.position).to eq(1)
      end     
    end

    context "with unauthenticated user" do
      it "redirects user to sign in page" do
        jane = Fabricate(:user)
        q1 = Fabricate(:queue_item, user: jane, position: 1)
        
        post :sort, queue_items: [{id: q1.id, position: 3}]
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with queue items that do not belong to the current user" do
      it "does not change the queue items" do
        jane = Fabricate(:user)
        bob = Fabricate(:user)
        session[:user_id] = bob.id
        q1 = Fabricate(:queue_item, user: bob, position: 1)
        q2 = Fabricate(:queue_item, user: jane, position: 2)
        
        post :sort, queue_items: [{id: q2.id, position: 1}]
        expect(q2.reload.position).to eq(2)
      end
    end
  end
end