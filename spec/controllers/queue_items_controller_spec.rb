require 'spec_helper'

describe QueueItemsController  do
  let!(:user1) {Fabricate(:user)}
  before {session[:user_id] = user1.id}

  describe 'GET index' do

    it_behaves_like "requires sign in" do
      let(:action) {get :index}
    end

    context "with queue itemes for authenticated user" do
      let!(:video)  {Fabricate(:video)}
      let!(:queue_item1) { Fabricate(:queue_item, user: current_user, position: 1, video: video)}
      let!(:queue_item2) {Fabricate(:queue_item, user: current_user, position: 2, video: video)}

      it "should set the @queue_items for the signed in user" do
        get :index
        expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
       end
    end
  end 

  describe 'POST create' do
    
    it_behaves_like "requires sign in" do
      let(:action) { post :create}
    end
    
    context "with signed_in user at a video show page" do
      let!(:video) {Fabricate(:video, title: 'Video1')}

      it "should redirect to my_queue"  do
        post :create, video_id: video.id 
        expect(response).to redirect_to my_queue_path
      end
      it "should create a new queue_item" do
        post :create, video_id: video.id 
        expect(QueueItem.count).to eq(1)
      end
      it "should associate the user with the queue_item" do
         post :create, video_id: video.id 
        expect(QueueItem.first.user).to eq(current_user)
        #or
        # expect(alice.queue_items.count).to eq(1)
      end
      it "should associate the video with the queue_item" do
        post :create, video_id: video.id 
        expect(QueueItem.first.video).to eq(video)
      end
      it "should not create duplicate items" do
        monk = Fabricate(:video)
        Fabricate(:queue_item, video: monk, user: current_user)
        post :create, video_id: monk.id 
        expect(QueueItem.count).to eq(1) 
      end
      it "should put the queue_item last in line" do
        monk = Fabricate(:video)          
        Fabricate(:queue_item, video: monk, user: current_user)
        up = Fabricate(:video)
        post :create, video_id: up.id 
        expect(QueueItem.last.position).to eq(2) 
      end
    end
  end 

  describe "POST update_queue" do
    let!(:video)  {Fabricate(:video)}
    let!(:queue_item1) { Fabricate(:queue_item, user: current_user, position: 1, video: video)}
    let!(:queue_item2) {Fabricate(:queue_item, user: current_user, position: 2, video: video)}
    
    it_behaves_like "requires sign in" do
      let(:action) {post :update_queue}
    end

    context "having existing queue items with position" do

      it "should redirect to my_queue page" do
         post :update_queue
         expect(response).to redirect_to my_queue_path
      end
      it "should update position" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}]
        expect(queue_item1.reload.position).not_to eq(1)
      end
      it "should reorder the items by ascending position" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}]
        expect(current_user.queue_items.load).to eq([queue_item2,queue_item1])
      end
      it "should normalize the values to be 1,2,3 etc" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}]
        expect(user1.queue_items.load.map(&:position)).to eq([1,2])
      end
    end 

    context "with invalid inputs," do
      def input_invalid_queue_position
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.4}, {id: queue_item2.id, position: 2}]
      end

      it "should redirect to the my queue page" do
        input_invalid_queue_position
        expect(response).to redirect_to my_queue_path
      end
      it "should set the flash error message" do
        input_invalid_queue_position
        expect(flash[:error]).to be_present
      end
      it "doesn't change the queue items" do
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2.1}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end

    context "attempting to change another users queue," do
      it "should fail" do
        bob = Fabricate(:user)
        queue_item3 = Fabricate(:queue_item, user: bob, position: 1, video: video)
        # queue_item2 = Fabricate(:queue_item, user: alice, position: 2, video: video)
        post :update_queue, queue_items: [{id: queue_item3.id, position: 7}]
        expect(queue_item3.reload.position).to eq(1)
      end
    end 
  end 

  describe "DELETE destroy"  do

    it_behaves_like "requires sign in" do
      let(:action) {delete :destroy, id: 3}
    end
   
    context "where there is an existing queue_item for the signed user" do 
      let!(:video)  {Fabricate(:video)}
      let!(:queue_item1) { Fabricate(:queue_item, user: current_user, position: 1, video: video)}
      let!(:queue_item2) {Fabricate(:queue_item, user: current_user, position: 2, video: video)}
      before {delete :destroy, id: queue_item1.id}

      it "should remove the item from the users queue" do
        expect(QueueItem.all).to eq([queue_item2])
      end
      it "should redirect to the my_queue page" do
        expect(response).to redirect_to my_queue_path
      end
    end
  end 

  describe '#already_queued?' do
    it "should return true if the video is in the queue" do
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: current_user)
      post :create, video_id: monk.id 
      expect(controller.already_queued?(monk)).to be_true
    end
  end 
end 