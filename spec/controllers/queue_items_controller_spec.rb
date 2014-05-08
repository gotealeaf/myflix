require 'spec_helper'

describe QueueItemsController do
  
  describe "GET index" do
    let(:jane) { Fabricate(:user) }
    let(:queue_item1) { Fabricate(:queue_item, user: current_user) }
    let(:queue_item2) { Fabricate(:queue_item, user: current_user) }
    
    it "should set the @queue_items instance variable for an authenticated user" do
      set_current_user(jane)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end
  
    it_behaves_like 'require sign in' do
      let(:action) { get :index }
    end
  end #ends GET index
  
  describe "POST create" do
    
    let(:jane) { Fabricate(:user) }
    let(:video) { Fabricate(:video) } 
    
    it 'should redirect to the my queue page' do
      set_current_user(jane)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end
  
    it 'should add a video when a signed in user clicks add to queue' do
      set_current_user(jane)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end
    
    it 'should create a queue item associated with the right video' do
      set_current_user(jane)
      post :create, video_id: video.id
      expect(QueueItem.first.video).to eq(video)
    end
    
    it 'should create a queue item associated with the right user' do
      set_current_user(jane)
      post :create, video_id: video.id
      expect(QueueItem.first.user). to eq(jane)
    end
    
    it 'should put the added video as the last one in the existing queue' do
      monk = Fabricate(:video)
      set_current_user(jane)
      queue_item = Fabricate(:queue_item, video: monk, user: jane)
      futurama = Fabricate(:video, title: 'Futurama')
      post :create, video_id: futurama.id
      futurama_queue_item = QueueItem.where(video_id: futurama.id, user_id: jane.id).first
      expect(futurama_queue_item.list_order).to eq(2)
    end
    
    it 'should not add a duplicate video if existing video title is already in the queue' do
      monk = Fabricate(:video)
      set_current_user(jane)
      queue_item = Fabricate(:queue_item, video: monk, user: jane, video_id: monk.id)
      post :create, video_id: monk.id
      expect(current_user.queue_items.count).to eq(1)
    end
    
    context 'unauthenticated user' do
  
      it 'should not add a video if the user is not signed in' do
        clear_current_user
        post :create
        expect(QueueItem.count).to eq(0) 
      end
      
      it_behaves_like 'require sign in' do
        let(:action) { post :create }
      end
      
      it 'should display an error message if user not signed in' do
        clear_current_user
        post :create
        expect(flash[:danger]).not_to be_blank
      end
    end
  end #ends POST Create
  
  describe "DELETE Destroy" do
    context 'authenticated users' do
      let(:jane) { Fabricate(:user) }
      
      it 'should delete the video when the user clicks on the delete button' do
        set_current_user(jane)
        video = Fabricate(:video)
        queue_item = Fabricate(:queue_item, video: video, user: jane)
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq(0)
      end
      
      it 'should redirect to the my queue page after user deletes video from queue' do
        set_current_user(jane)
        queue_item = Fabricate(:queue_item)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to my_queue_path
      end
    
      it 'should normalize the queue items list order if an item has been deleted' do
        set_current_user(jane)
        queue_item1 = Fabricate(:queue_item, user: jane, list_order: 1)
        queue_item2 = Fabricate(:queue_item, user: jane, list_order: 2)
        delete :destroy, id: queue_item1.id
        expect(QueueItem.first.list_order).to eq(1)
      end
      
      it "does not delete the queue item if the queue item is not in the current user's queue" do
        set_current_user(jane)
        james = Fabricate(:user)
        queue_item = Fabricate(:queue_item, user: james)
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq(1)
      end
    end
    
    context 'unauthenticated users' do
    
      it_behaves_like 'require sign in' do
        let(:action) { delete :destroy, id: 3 }
      end
    end
  end #ends Delete destroy
  
  describe "POST update_queue" do
    
    context "valid input" do
      let(:jane) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:video2) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: jane, list_order: 1, video: video) }
      let(:queue_item2) { Fabricate(:queue_item, user: jane, list_order: 2, video: video2) }
      before do
        set_current_user(jane)
      end
      
      it 'should update list order of the queue items' do
        post :update_queue, queue_items: [{id: queue_item1.id, list_order: 2}, {id: queue_item2.id, list_order: 1}]
        expect(jane.queue_items).to eq([queue_item2, queue_item1])
      end
      
      it 'should redirect to the my queue page' do
        post :update_queue, queue_items: [{id: queue_item1.id, list_order: 2}, {id: queue_item2.id, list_order: 1}]
        expect(response).to redirect_to my_queue_path
      end
       
      it 'should normalize the list order of the queue page' do
        post :update_queue, queue_items: [{id: queue_item1.id, list_order: 3}, {id: queue_item2.id, list_order: 2}]
        expect(jane.queue_items.map(&:list_order)).to eq([1, 2])
      end
    end #ends valid input context
    
    context "invalid input" do
      let(:jane) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:video2) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: jane, list_order: 1, video: video) }
      let(:queue_item2) { Fabricate(:queue_item, user: jane, list_order: 2, video: video2) }
      before do
        set_current_user(jane)
      end
      it 'should not update the queue items' do
        post :update_queue, queue_items: [{id: queue_item1.id, list_order: 3}, {id: queue_item2.id, list_order: 2.1}]
        expect(queue_item1.reload.list_order).to eq(1)
      end
      
      it 'redirects to the my queue page' do
        post :update_queue, queue_items: [{id: queue_item1.id, list_order: 3.4}, {id: queue_item2.id, list_order: 1}]
        expect(response).to redirect_to my_queue_path
      end
      
      it 'should show a flash message indicating error' do
        post :update_queue, queue_items: [{id: queue_item1.id, list_order: 3.4}, {id: queue_item2.id, list_order: 1}]
        expect(flash[:danger]).not_to be_blank
      end
    end #ends invalid input context
    
    context "unauthenticated user" do
      
      it_behaves_like 'require sign in' do
        let(:action) { post :update_queue, queue_items: [{id: 1, list_order: 3}, {id: 2, list_order: 1}] }
      end
    end
    
    context "queue items that do not belong to the current user" do
      it 'should not reorder the queue items' do
        jane = Fabricate(:user)
        bob = Fabricate(:user)
        video = Fabricate(:video)
        video2 = Fabricate(:video)
        set_current_user(jane)
        queue_item1 = Fabricate(:queue_item, user: jane, list_order: 1, video: video)
        queue_item2 = Fabricate(:queue_item, user: bob, list_order: 2, video: video2)
        post :update_queue, queue_items: [{id: queue_item1.id, list_order: 3}, {id: queue_item2.id, list_order: 2}]
        expect(queue_item1.reload.list_order).to eq(1)
      end
    end #ends the context
  end #ends POST update_queue
end #ends queue items controller