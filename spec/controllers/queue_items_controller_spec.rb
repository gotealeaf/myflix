require "spec_helper"

describe QueueItemsController do
  context "authenticated user" do  

    let(:user){ Fabricate :user }    
    let(:video){ Fabricate :video }     

    before do
      session[:user_id] = user.id
    end

    describe "GET index" do
      it "sets @my_queue variable" do 
        queue_item1 = Fabricate(:queue_item, user: user)
        queue_item2 = Fabricate(:queue_item, user: user)
        queue_item3 = Fabricate(:queue_item, user: user)

        get :index

        expect(assigns :queue_items).to match_array([queue_item1, queue_item2, queue_item3])
      end
    end

    describe "POST create" do
    
      it "redirects to my_queue_path" do
        post :create, video_id: video.id  
        expect(response).to redirect_to my_queue_path
      end

      it "creates a queue_item" do   
        post :create, video_id: video.id  
        expect(QueueItem.count).to eq(1)
      end

      it "creates a queue_item associated with the current video" do
        post :create, video_id: video.id  
        expect(QueueItem.first.video).to eq(video)
      end

      it "creates a queue_item associated with the current user" do
        post :create, video_id: video.id  
        expect(QueueItem.first.user).to eq(user)
      end

      it "sets the video the last one in the user's queue" do
        Fabricate(:queue_item, user: user, video: video, order: 2)
        video1 = Fabricate :video
        post :create, video_id: video1.id  
        video1_queue_item = QueueItem.where(user: user, video: video1).first                  
        expect(video1_queue_item.order).to eq(2)          
      end

      it "does not add the video to the queue if the video is already in it" do
        Fabricate(:queue_item, user: user, video: video, order: 2)
        post :create, video_id: video.id  
        expect(QueueItem.count).to eq(1)  
      end
    end

    describe "DELETE destroy" do

      it "redirects to my_queue page" do
        queue_item = Fabricate :queue_item
        delete :destroy, id: queue_item.id

        expect(response).to redirect_to my_queue_path
      end

      it "removes the selected queue_item" do
        queue_item = Fabricate(:queue_item, user: user)
        delete :destroy, id: queue_item.id

        expect(QueueItem.count).to eq(0)  
      end

      it "normalizes the remaining queue items" do
          qi1 = Fabricate :queue_item, user: user, order: 1
          qi2 = Fabricate :queue_item, user: user, order: 2

          delete :destroy, id: qi1.id

          expect(qi2.reload.order).to eq(1)
      end

      it "does not delete the queue_item if the queue_item is not in the user's queue" do
        user1 = Fabricate :user
        queue_item = Fabricate(:queue_item, user: user1)
        delete :destroy, id: queue_item.id

        expect(QueueItem.count).to eq(1)
      end
    end

    describe "POST update_queue" do
      context "with valid inputs" do
        it "redirects to my_queue page" do
          qi1 = Fabricate :queue_item, user: user, order: 1
          queue_items = [{ id: qi1.id, order: 2 }]

          post :update_queue, queue_items: queue_items

          expect(response).to redirect_to my_queue_path
        end

        it "updates the order of many queue elements" do
          qi1 = Fabricate :queue_item, user: user, order: 1
          qi2 = Fabricate :queue_item, user: user, order: 2
          qi3 = Fabricate :queue_item, user: user, order: 3
          qi4 = Fabricate :queue_item, user: user, order: 4
          queue_items = [{ id: qi1.id, order: 2 }, { id: qi2.id, order: 1 }, { id: qi3.id, order: 4 }, { id: qi4.id, order: 3 }]

          post :update_queue, queue_items: queue_items

          expect([1 ,2, 3, 4]).to eq([QueueItem.find(qi2.id).order, QueueItem.find(qi1.id).order, QueueItem.find(qi4.id).order, QueueItem.find(qi3.id).order])
        end

        it "reorders the queue following the new order" do
          qi1 = Fabricate :queue_item, user: user, order: 1
          qi2 = Fabricate :queue_item, user: user, order: 2
          qi3 = Fabricate :queue_item, user: user, order: 3
          qi4 = Fabricate :queue_item, user: user, order: 4
          queue_items = [{ id: qi1.id, order: 2 }, { id: qi2.id, order: 1 }, { id: qi3.id, order: 4 }, { id: qi4.id, order: 3 }]

          post :update_queue, queue_items: queue_items

          expect(user.queue_items).to eq([qi2, qi1, qi4, qi3])
        end

        it "normalizes position numbers" do
          qi1 = Fabricate :queue_item, user: user, order: 1
          qi2 = Fabricate :queue_item, user: user, order: 2
          qi3 = Fabricate :queue_item, user: user, order: 3
          qi4 = Fabricate :queue_item, user: user, order: 4
          queue_items = [{ id: qi1.id, order: 5 }, { id: qi2.id, order: 2 }, { id: qi3.id, order: 3 }, { id: qi4.id, order: 4 }]

          post :update_queue, queue_items: queue_items

          expect(user.queue_items.map(&:order)).to eq([1, 2, 3, 4])
        end
      end

      context "videos without a review created by the logged user" do
        it "creates a review that belongs to the current user" do
          qi1 = Fabricate :queue_item, user: user, video: video, order: 1
          queue_items = [{ id: qi1.id, order: 1,rating: 3 }]   

          post :update_queue, queue_items: queue_items

          expect(Review.count).to eq(1)  
        end

        it "creates the review setting rating with the input"
      end

      context "videos with reviews already done by the logged user" do
        it "updates queue items rating" do
          # video1 = Fabricate :video
          # review1 = Fabricate :review, video: video, creator: user, rating: 2
          # review2 = Fabricate :review, video: video1, creator: user, rating: 3
          # qi1 = Fabricate :queue_item, user: user, video: video, order: 1
          # qi2 = Fabricate :queue_item, user: user, video: video1, order: 2       
          # queue_items = [{ id: qi1.id, order: 1,rating: 3 }, { id: qi2.id, order: 2, rating: 4 }]   

          # post :update_queue, queue_items: queue_items

          # expect([QueueItem.find(qi1.id).rating, QueueItem.find(qi2.id).rating]).to eq([3, 4])  
        end

        it "does not create a review of video if current user already has one done"        
      end

      context "with invalid inputs" do
        it "redirects to my_queue page" do
          queue_item1 = Fabricate :queue_item, user: user, order: 1
          queue_items = [{ id: queue_item1.id, order: 3.4 }]

          post :update_queue, queue_items: queue_items

          expect(response).to redirect_to my_queue_path
        end

        it "sets the flash error message" do
          queue_item1 = Fabricate :queue_item, user: user, order: 1
          queue_items = [{ id: queue_item1.id, order: 2.2 }]

          post :update_queue, queue_items: queue_items

          expect(flash[:error]).to be_present
        end

        it "does not update queue elements if the input are not integers" do
          qi1 = Fabricate :queue_item, user: user, order: 1
          qi2 = Fabricate :queue_item, user: user, order: 2

          queue_items = [{ id: qi1.id, order: 3 }, { id: qi2.id, order: 2.2 }]

          post :update_queue, queue_items: queue_items

          expect(qi1.reload.order).to eq(1)
        end
      end

      context "with queue items that do not belong to the current user" do
        it "does not change the queue items position" do
          user2 = Fabricate :user
          qi1 = Fabricate :queue_item, user: user2, order: 1
          qi2 = Fabricate :queue_item, user: user2, order: 2

          queue_items = [{ id: qi1.id, order: 3 }, { id: qi2.id, order: 2 }]

          post :update_queue, queue_items: queue_items

          expect(qi1.reload.order).to eq(1)
        end

        it "does not change the queue items rating"
      end
    end
  end

  context "unauthenticated user" do 
    describe "GET index" do
      it "redirects to sign_in page" do 
        get :index
        expect(response).to redirect_to sign_in_path
      end
    end

    describe "POST create" do
      it "redirects to sign_in_path" do
        video = Fabricate :video
        post :create, video_id: video.id  
        expect(response).to redirect_to sign_in_path
      end
    end

    describe "DELETE destroy" do
      it "redirects to sign_in_path" do
        delete :destroy, id: 3
        expect(response).to redirect_to sign_in_path
      end
    end

    describe "POST update_queue" do
      it "redirects to sign_in_path" do
        queue_items = [{ id: 1, order: 3 }, { id: 2, order: 2.2 }]

        post :update_queue, queue_items: queue_items
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end