require "spec_helper"

describe QueueItemsController do
  context "authenticated user" do  

    let(:the_wire){ Fabricate :video }     
    let(:the_sopranos){ Fabricate :video }
    let(:purgatorio){ Fabricate :video }

    before { set_current_user }
  
    describe "GET index" do
      it "sets @my_queue variable" do 
        queue_item1 = Fabricate(:queue_item, user: current_user)
        queue_item2 = Fabricate(:queue_item, user: current_user)
        queue_item3 = Fabricate(:queue_item, user: current_user)

        get :index

        expect(assigns :queue_items).to match_array([queue_item1, queue_item2, queue_item3])
      end
    end

    describe "POST create" do
    
      it "redirects to my_queue_path" do
        post :create, video_id: the_wire.id  
        expect(response).to redirect_to my_queue_path
      end

      it "creates a queue_item" do   
        post :create, video_id: the_wire.id  
        expect(QueueItem.count).to eq(1)
      end

      it "creates a queue_item associated with the current video" do
        post :create, video_id: the_wire.id  
        expect(QueueItem.first.video).to eq(the_wire)
      end

      it "creates a queue_item associated with the current user" do
        post :create, video_id: the_wire.id  
        expect(QueueItem.first.user).to eq(current_user)
      end

      it "sets the video the last one in the user's queue" do
        Fabricate(:queue_item, user: current_user, video: the_wire, order: 2)
        post :create, video_id: the_sopranos.id  
        video1_queue_item = QueueItem.where(user: current_user, video: the_sopranos).first                  
        expect(video1_queue_item.order).to eq(2)          
      end

      it "does not add the video to the queue if the video is already in it" do
        Fabricate(:queue_item, user: current_user, video: the_wire, order: 2)
        post :create, video_id: the_wire.id  
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
        queue_item = Fabricate(:queue_item, user: current_user)
        delete :destroy, id: queue_item.id

        expect(QueueItem.count).to eq(0)  
      end

      it "normalizes the remaining queue items" do
          qi1 = Fabricate :queue_item, user: current_user, order: 1
          qi2 = Fabricate :queue_item, user: current_user, order: 2

          delete :destroy, id: qi1.id

          expect(qi2.reload.order).to eq(1)
      end

      it "does not delete the queue_item if the queue_item is not in the user's queue" do
        tom = Fabricate :user
        queue_item = Fabricate(:queue_item, user: tom)
        delete :destroy, id: queue_item.id

        expect(QueueItem.count).to eq(1)
      end
    end

    describe "POST update_queue" do
      context "with valid inputs" do
        it "redirects to my_queue page" do
          qi1 = Fabricate :queue_item, user: current_user, video: the_wire, order: 1
          queue_items = [{ id: qi1.id, order: 2 }]

          post :update_queue, queue_items: queue_items

          expect(response).to redirect_to my_queue_path
        end

        it "updates the order of many queue elements" do
          qi1 = Fabricate :queue_item, user: current_user, video: the_wire, order: 1
          qi2 = Fabricate :queue_item, user: current_user, video: the_sopranos, order: 2
          qi3 = Fabricate :queue_item, user: current_user, video: purgatorio, order: 3

          post :update_queue, queue_items: [{ id: qi1.id, order: 2, rating:1 }, { id: qi2.id, order: 1, rating:1 }, { id: qi3.id, order: 4, rating: 1 }]

          expect([1 ,2, 3]).to eq([QueueItem.find(qi2.id).order, QueueItem.find(qi1.id).order, QueueItem.find(qi3.id).order])
        end

        it "reorders the queue following the new order" do
          qi1 = Fabricate :queue_item, user: current_user, video: the_wire, order: 1
          qi2 = Fabricate :queue_item, user: current_user, video: the_sopranos, order: 2
          qi3 = Fabricate :queue_item, user: current_user, video: purgatorio, order: 3

          post :update_queue, queue_items: [{ id: qi1.id, order: 2 }, { id: qi2.id, order: 1 }, { id: qi3.id, order: 4 }]

          expect(current_user.queue_items).to eq([qi2, qi1, qi3])
        end

        it "normalizes position numbers" do
          qi1 = Fabricate :queue_item, user: current_user, video: the_wire, order: 1
          qi2 = Fabricate :queue_item, user: current_user, video: the_sopranos, order: 2
          qi3 = Fabricate :queue_item, user: current_user, video: purgatorio, order: 3

          post :update_queue, queue_items: [{ id: qi1.id, order: 5 }, { id: qi2.id, order: 2 }, { id: qi3.id, order: 3 }]

          expect(current_user.queue_items.map(&:order)).to eq([1, 2, 3])
        end

        context "the video has not a review created by the logged user" do
          it "creates a review that belongs to the current user setting the input rating" do
            qi1 = Fabricate :queue_item, user: current_user, video: the_wire, order: 1
            post :update_queue, queue_items: [{ id: qi1.id, order: 1, rating: 3 }]  

            expect(Review.count).to eq(1)  
          end
        end

        context "the video has already a review created by the logged user" do
          it "does not create a review if current user already has one done" do
            qi1 = Fabricate :queue_item, user: current_user, video: the_wire, order: 1
            review1 = Fabricate :review, video: the_wire, creator: current_user, rating: 2

            post :update_queue, queue_items: [{ id: qi1.id, order: 1, rating: 3 }] 

            expect(Review.count).to eq(1) 
          end

          it "updates queue items rating" do
            review1 = Fabricate :review, video: the_wire, creator: current_user, rating: 2
            review2 = Fabricate :review, video: the_sopranos, creator: current_user, rating: 3
            qi1 = Fabricate :queue_item, user: current_user, video: the_wire, order: 1
            qi2 = Fabricate :queue_item, user: current_user, video: the_sopranos, order: 2       

            post :update_queue, queue_items: [{ id: qi1.id, order: 1,rating: 3 }, { id: qi2.id, order: 2, rating: 4 }] 
            
            expect([QueueItem.find(qi1.id).rating, QueueItem.find(qi2.id).rating]).to eq([3, 4])  
          end             
        end
      end

      context "with invalid inputs" do
        it "redirects to my_queue page" do
          queue_item1 = Fabricate :queue_item, user: current_user, video: the_wire, order: 1
          post :update_queue, queue_items: [{ id: queue_item1.id, order: 3.4 }]

          expect(response).to redirect_to my_queue_path
        end

        it "sets the flash error message" do
          queue_item1 = Fabricate :queue_item, user: current_user, video: the_wire, order: 1
          post :update_queue, queue_items: [{ id: queue_item1.id, order: 2.2 }]

          expect(flash[:error]).to be_present
        end

        it "does not update queue elements if the input are not integers" do
          qi1 = Fabricate :queue_item, user: current_user, video: the_wire, order: 1
          qi2 = Fabricate :queue_item, user: current_user, video: the_sopranos, order: 2

          post :update_queue, queue_items: [{ id: qi1.id, order: 3 }, { id: qi2.id, order: 2.2 }]

          expect(qi1.reload.order).to eq(1)
        end

        it "does not change the queue items rating" do
          review1 = Fabricate :review, video: the_wire, creator: current_user, rating: 2
          qi1 = Fabricate :queue_item, user: current_user, video: the_wire, order: 1

          post :update_queue, queue_items: [{ id: qi1.id, order: 1.1,rating: 3 }] 
          
          expect(QueueItem.find(qi1.id).rating).to eq(2)            
        end
      end

      context "with queue items that do not belong to the current user" do
        it "does not change the queue items position" do
          tom = Fabricate :user
          qi1 = Fabricate :queue_item, user: tom, video: the_wire, order: 1
          qi2 = Fabricate :queue_item, user: tom, video: the_sopranos, order: 2

          post :update_queue, queue_items: [{ id: qi1.id, order: 3 }, { id: qi2.id, order: 2 }]
          
          expect(qi1.reload.order).to eq(1)
        end

        it "does not change the queue items rating" do
          tom = Fabricate :user
          review1 = Fabricate :review, video: the_wire, creator: tom, rating: 2
          qi1 = Fabricate :queue_item, user: tom, video: the_wire, order: 1

          post :update_queue, queue_items: [{ id: qi1.id, order: 1,rating: 3 }] 
          
          expect(QueueItem.find(qi1.id).rating).to eq(2)            
        end
      end
    end
  end

  context "unauthenticated user" do 
    describe "GET index" do
      it_behaves_like "require_sign_in" do
        let(:action) { get :index }
      end
    end

    describe "POST create" do
      it_behaves_like "require_sign_in" do
        the_wire = Fabricate :video
        let(:action) { post :create,  video_id: the_wire.id }
      end
    end

    describe "DELETE destroy" do
      it_behaves_like "require_sign_in" do
        let(:action) { delete :destroy, id: 3 }
      end
    end

    describe "POST update_queue" do
      it_behaves_like "require_sign_in" do
        let(:action) { post :update_queue, queue_items: [{ id: 1, order: 3 }, { id: 2, order: 2.2 }] }
      end
    end
  end
end