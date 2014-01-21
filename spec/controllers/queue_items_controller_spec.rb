require 'spec_helper'

describe QueueItemsController  do

  describe 'GET index' do
    context "with unauthenticated user" do
      it "should redirect to the sign_in page" do
        get :index
        expect(response).to redirect_to sign_in_path
      end
    end
    context "with queue itemes for authenticated user" do
      let(:alice)  {Fabricate(:user)}
      let(:queue_item1) { Fabricate(:queue_item, user: alice) }
      let(:queue_item2)  {Fabricate(:queue_item, user: alice) }
      before { 
        session[:user_id]= alice.id 
        get :index
      }
      
      it "should set the @queue_items for the signed in user" do
        expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
       end
    end
  end 

  describe 'POST create' do
    context "with unauthenticated user" do
      it "should redirect to the sign_in page" do
        post :create
        expect(response).to redirect_to sign_in_path
      end
    end
    context "with signed_in user at a video show page" do 
       let(:alice)  {Fabricate(:user)}
       let(:a_video)  {Fabricate(:video)}
       before { 
         session[:user_id] = alice.id 
               }

       it "shoule redirect to my_queue"  do
        post :create, video_id: a_video.id  
        expect(response).to redirect_to my_queue_path
       end

       it "should create a new queue_item" do
        post :create, video_id: a_video.id  
          expect(QueueItem.count).to eq(1)
       end

       it "should associate the user with the queue_item" do
        post :create, video_id: a_video.id  
          expect(QueueItem.first.user).to eq(alice)
          #or
          # expect(alice.queue_items.count).to eq(1)
       end

       it "should associate the video with the queue_item" do
        post :create, video_id: a_video.id  
          expect(QueueItem.first.video).to eq(a_video)
       end

        it "should not create duplicate items" do
          monk = Fabricate(:video)
          Fabricate(:queue_item, video: monk, user: alice)
          post :create, video_id: monk.id 
          expect(QueueItem.count).to eq(1) 
        end
         
        it "should put the queue_item last in line" do
          monk = Fabricate(:video)          
          Fabricate(:queue_item, video: monk, user: alice)
          up = Fabricate(:video)
          post :create, video_id: up.id 
          expect(QueueItem.last.position).to eq(2) 
        end
     end
  end

  describe "POST update_queue" do
 
    context "with unauthenticated user" do
      it "should redirect to sign_in_path" do
        post :update_queue
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with authenticated user," do
      let(:alice) {Fabricate(:user)}
      before {session[:user_id] = alice.id}

      it "should redirect to my_queue page" do
        post :update_queue
        expect(response).to redirect_to my_queue_path
      end
     
      context "having existing queue items with position," do
        # let(:video) { Fabricate(:video) }
        # let(:queue_item1) {Fabricate(:queue_item, user: alice, position: 1, video: video)}
        # let(:queue_item2) {Fabricate(:queue_item, user: alice, position: 2, video: video)}

        it "should update position" do
          video = Fabricate(:video)
          queue_item1 = Fabricate(:queue_item, user: alice, position: 1, video: video)
          queue_item2 = Fabricate(:queue_item, user: alice, position: 2, video: video)
          post :update_queue, queue_items: [{id: queue_item1.id, position: 3}]
          expect(queue_item1.reload.position).not_to eq(1)
        end

        it "should reorder the items by ascending position" do
          video = Fabricate(:video)
          queue_item1 = Fabricate(:queue_item, user: alice, position: 1, video: video)
          queue_item2 = Fabricate(:queue_item, user: alice, position: 2, video: video)
          post :update_queue, queue_items: [{id: queue_item1.id, position: 3}]
          expect(alice.queue_items.load).to eq([queue_item2,queue_item1])

        end

        it "should normalize the values to be 1,2,3 etc" do
          video = Fabricate(:video)
          queue_item1 = Fabricate(:queue_item, user: alice, position: 3, video: video)
          queue_item2 = Fabricate(:queue_item, user: alice, position: 5, video: video)
          post :update_queue, queue_items: [{id: queue_item1.id, position: 7}]
          expect(alice.queue_items.load.map(&:position)).to eq([1,2])
        end

      end

      context "attempting to change another users queue," do
        it "should fail" do
          bob = Fabricate(:user)
          video = Fabricate(:video)
          queue_item1 = Fabricate(:queue_item, user: bob, position: 1, video: video)
          queue_item2 = Fabricate(:queue_item, user: alice, position: 2, video: video)
          post :update_queue, queue_items: [{id: queue_item1.id, position: 7}]
          expect(queue_item1.reload.position).to eq(1)
        end
      end



    end

  end



  describe "DELETE destroy"  do
   context "with unauthenticated user" do
      it "should redirect to the sign_in page" do
        delete :destroy, id: 3
        expect(response).to redirect_to sign_in_path
      end
    end

    context "where there is an existing queue_item for the signed user" do 
      let(:alice) {Fabricate(:user)}
      before {session[:user_id] = alice.id}
      let(:monk) {Fabricate(:video)}
      let(:queue_item1) {Fabricate(:queue_item, user: alice, video: monk)}
      before {delete :destroy, id: queue_item1.id}


      it "should remove the item from the users queue" do
        expect(QueueItem.count).to eq(0)
      end

      it "should redirect to the my_queue page" do
        expect(response).to redirect_to my_queue_path

      end
    end
  end
end

