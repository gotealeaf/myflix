require 'rails_helper'

describe QueueItemsController do

  context "signed in users" do
    
    before { set_current_user }
    let(:user) { current_user }
    let(:video) { Fabricate(:video) }

    describe "GET index" do

      it "should assign the @queue_items variable for the signed in user" do
        qitem = Fabricate(:queue_item, video: video, user: user)
        qitem2 = Fabricate(:queue_item, video: video, user: user)
        get :index
        expect(assigns(:queue_items)).to match_array([qitem,qitem2])
      end
      
    end

    describe "POST create" do
      
      it "should create a queue item from valid values" do
        post :create, video_id: video.id
        expect(QueueItem.count).to eq(1)
      end
      it "should set a flash success message when created" do
        post :create, video_id: video.id
        expect(flash[:success]).not_to be_blank
      end
      it "should redirect to my queue" do
        post :create, video_id: video.id
        expect(response).to redirect_to(my_queue_path)
      end
      it "should add a new queue item for the signed in user" do
        post :create, video_id: video.id
        expect(QueueItem.first.user).to eq(user)
      end
      it "should add a new queue item for the video" do
        post :create, video_id: video.id
        expect(QueueItem.first.video).to eq(video)
      end
      it "puts the video as the last one in the queue" do
        Fabricate(:queue_item, user: user)
        superman = Fabricate(:video)
        post :create, video_id: superman.id
        super_queue_item = QueueItem.where(video:superman,user:user).first
        expect(super_queue_item.position).to eq(2)
      end
      it "does not add the video if the video is already in the queue" do
        Fabricate(:queue_item, user: user, video: video)
        post :create, video_id: video.id
        expect(user.queue_items.count).to eq(1)
      end
      it "should set a flash info message if the video is already in the user queue" do
        Fabricate(:queue_item, user: user, video: video)
        post :create, video_id: video.id
        expect(flash[:info]).not_to be_blank
      end
    end

    describe "DELETE destroy" do

      it "should remove the queue item from the user's queue" do
        qitem = Fabricate(:queue_item, user: user, video: video)
        delete :destroy, id: qitem.id
        expect(user.queue_items.count).to eq(0)
      end
      it "should redirect to the my queue page" do
        qitem = Fabricate(:queue_item, user: user, video: video)
        delete :destroy, id: qitem.id
        expect(response).to redirect_to(my_queue_path)
      end
      it "should place a flash success informing user video was removed" do
        qitem = Fabricate(:queue_item, user: user, video: video)
        delete :destroy, id: qitem.id
        expect(flash[:success]).not_to be_blank
      end
      it "does not delete queue item if it does not belong to the current user" do
        joker = Fabricate(:user)
        qitem = Fabricate(:queue_item, user: joker, video: video)
        delete :destroy, id: qitem.id
        expect(joker.queue_items.count).to eq(1)
      end
      it "should renormalize remaining queue item positions" do
        item1 = Fabricate(:queue_item, user: user, position: 1)
        item2 = Fabricate(:queue_item, user: user, position: 2)
        delete :destroy, id: item1.id
        item2.reload
        expect(item2.position).to eq(1)
      end
    end
    
    describe "PUT update" do
      
      describe "update positions" do
        let(:video) { Fabricate(:video) }
        let(:video2) { Fabricate(:video) }
        let(:qitem1) { Fabricate(:queue_item, user: user, video: video, position: 1) }
        let(:qitem2) { Fabricate(:queue_item, user: user, video: video2, position: 2) }
        
        it "should reorder queue items based on user input" do
          post :update_queue, items: [{id: qitem1.id, position: 3}, {id: qitem2.id, position: 1}]
          qitem1.reload;qitem2.reload
          expect(qitem1.position).to eq(2)
          expect(qitem2.position).to eq(1)
        end
        it "should have queue items sorted by position" do
          post :update_queue, items: [{id: qitem1.id, position: 3}, {id: qitem2.id, position: 1}]
          expect(user.queue_items).to eq([qitem2,qitem1])
        end
        it "should use the order numbers as relative, but assign numbers sequentially" do
          post :update_queue, items: [{id: qitem1.id, position: 2}, {id: qitem2.id, position: 5}]
          qitem1.reload;qitem2.reload
          expect(qitem2.position).to eq(2)
          expect(qitem1.position).to eq(1)
        end
        it "should redirect to the my_queque path" do
          post :update_queue, items: [{id: qitem1.id, position: 2}, {id: qitem2.id, position: 1}]
          expect(response).to redirect_to(my_queue_path)
        end
        it "should add a flash:success message for correct values" do
          post :update_queue, items: [{id: qitem1.id, position: 2}, {id: qitem2.id, position: 1}]
          expect(flash[:success]).not_to be_blank
        end
        it "should give a flash:danger with invalid input" do
          post :update_queue, items: [{id: qitem1.id, position: 2.5}, {id: qitem2.id, position: 5}]
          expect(flash[:danger]).not_to be_blank
        end
        it "should not change queue items with invalid inputs" do
          post :update_queue, items: [{id: qitem1.id, position: 2.5}, {id: qitem2.id, position: 1}]
          qitem1.reload;qitem2.reload
          expect(qitem1.position).to eq(1)
          expect(qitem2.position).to eq(2)
        end
        it "should not update the positions of other user's items" do
          second_user = Fabricate(:user)
          other_item = Fabricate(:queue_item, position: 2, video: video)
          post :update_queue, items: [{id: other_item.id, position: 1}]
          other_item.reload
          expect(other_item.position).to eq(2)
        end
      end
      
      describe "update ratings" do
        let(:video) { Fabricate(:video) }
        let(:video2) { Fabricate(:video) }
        let(:qitem1) { Fabricate(:queue_item, user: user, video: video, position: 1) }
        let(:qitem2) { Fabricate(:queue_item, user: user, video: video2, position: 2) }
      
        it "should update the ratings for an existing review on a queue item"  do
          review_one = Fabricate(:review, user: user, video: video, rating: 1)
          review_two = Fabricate(:review, user: user, video: video2, rating: 2)
          post :update_queue, items: [{id: qitem1.id, rating: 4, position: 1}, {id: qitem2.id, rating: 5, position: 2}]
          review_one.reload;
          expect(review_one.rating).to eq(4)
        end
        it "should create a new review when a rating is select for an item without a review" do
          post :update_queue, items: [{id: qitem1.id, rating: 4, position: 1}]
          expect(video.reviews.count).to eq(1)
          expect(video.reviews.first.rating).to eq(4)
        end
        it "should not update the ratings of another user's item or create a new review" do
          user_two = Fabricate(:user)
          other_qi = Fabricate(:queue_item, user: user_two, video: video)
          other_review = Fabricate(:review, video: video, user: user_two, rating: 5)
          total_reviews = Review.count
          post :update_queue, items: [{id: other_qi.id, rating: 1, position: 1}]
          other_review.reload
          expect(other_review.rating).to eq(5)
          expect(Review.count).to eq(total_reviews)
        end
        it "should not error if no rating is provided but a position is" do
           post :update_queue, items: [{id: qitem1.id, rating: '', position: 2},{id: qitem2.id, rating: '', position: 1}]
           qitem1.reload
           expect(qitem1.rating).to eq(nil)
           expect(qitem1.position).to eq(2)
        end
      end
      
    end

  end

  context "users who are NOT signed in" do
    describe "GET index" do
      it "should redirect to the sign_in page" do
        get :index
        expect(response).to redirect_to(sign_in_path)
      end
    end
    describe "POST create" do
      it "should redirect to sign_in page" do
        post :create
        expect(response).to redirect_to(sign_in_path)
      end
    end
    describe "DELETE destroy" do
      it "should redirect to sign_in page" do
        qitem = Fabricate(:queue_item)
        delete :destroy, id: qitem.id
        expect(response).to redirect_to(sign_in_path)
      end
    end
    describe "POST update" do
      it "should redirect to sign_in page" do
        post :update_queue, items: [{id: 1, position: 1}]
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

end
