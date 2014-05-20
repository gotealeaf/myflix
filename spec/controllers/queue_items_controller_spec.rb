require 'spec_helper'

describe QueueItemsController do

  context "with an authenticated user" do
    let(:current_user) {Fabricate(:user)}
    before do
      session[:user_id] = current_user.id
    end
    describe "GET #index" do
      before do
        Fabricate(:queue_item, user: current_user)
        Fabricate(:queue_item, user: current_user)
      end
      
      it "assignes @queue_items" do
        get :index
        expect(assigns(:queue_items).count).to eq(2)      
      end
      it "includes all queue_items for the current user" do
        get :index
        expect(assigns(:queue_items)).to match_array(current_user.queue_items)      
      end
      it "does not include any queue items for other users" do
        other_user_item = Fabricate(:queue_item)
        get :index
        expect(assigns(:queue_items)).not_to include(other_user_item)      
      end
      it "it renders the index page" do
        get :index
        expect(response).to render_template(:index)
      end
    end
    
    describe "POST #create" do
      let(:video) {Fabricate(:video)}
      it "adds the video to the current users queue if it does not already exist" do
        post :create, {video_id: video.id}
        expect(current_user.queue_items.count).to eq(1)
      end
      it "sets the position of the item to the end of the queue" do
        Fabricate(:queue_item, user: current_user)
        post :create, {video_id: video.id}
        expect(current_user.queue_items.order(:position).last.position).to eq(current_user.queue_items.count)
      end
      it "redirects to the My Queue page" do
        post :create, {video_id: video.id}
        expect(response).to redirect_to(:my_queue)
      end
      it "creates a queue item that is associated with this video" do
        post :create, {video_id: video.id}
        expect(current_user.queue_items.first.video).to eq(video)
      end
      it "does not add the video if it is already in the queue" do
        Fabricate(:queue_item, video: video, user: current_user)
        post :create, {video_id: video.id}
        expect(current_user.queue_items.count).to eq(1)
      end
    end
    
    describe "DELETE #destroy" do
      it "redirects to the my queue page" do
        item = Fabricate(:queue_item, user: current_user)
        delete :destroy, {id: item.id}
        expect(response).to redirect_to(:my_queue)
      end
      it "deletes the item from the queue" do
        item = Fabricate(:queue_item, user: current_user)
        delete :destroy, {id: item.id}
        expect(QueueItem.count).to eq(0)
      end
      it "does not delete the item if it is not in the current users queue" do
        item = Fabricate(:queue_item)
        delete :destroy, {id: item.id}
        expect(QueueItem.count).to eq(1)
      end
    end
    
  end
  
  context "with an unauthenticated user" do

    describe "GET #index" do
      it "redirects to the sign in page" do
        get :index
        expect(response).to redirect_to(sign_in_path)
      end
    end

    describe "POST #create" do
      it "redirects to the sign in page" do
        video = Fabricate(:video)
        post :create, {video_id: video.id}
        expect(response).to redirect_to(sign_in_path)
      end
    end

    describe "DELETE #destroy" do
      it "redirects to the sign in page" do
        item = Fabricate(:queue_item)
        delete :destroy, {id: item.id}
        expect(response).to redirect_to(sign_in_path)
      end
    end
    
  end
  
end
