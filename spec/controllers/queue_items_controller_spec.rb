require 'spec_helper'

describe QueueItemsController do

  describe 'GET index' do
    context "for authenticated (signed in) users" do
      let(:current_user) { Fabricate(:user) }
      let(:video)        { Fabricate(:video) }
      let(:queue_item)   { Fabricate(:queue_item, video: video, user: current_user) }

      before do
        session[:user_id] = current_user.id
        get :index
      end

      it "loads the current_user's @queue_items variable" do
        expect(assigns(:queue_items)).to eq([queue_item])
      end
      it "renders the index page" do
        expect(response).to render_template :index
      end
    end

    context "for UNauthenticated users (guests)" do
      it "redirects to the signin page" do
        get :index
        expect(response).to redirect_to signin_path
      end
    end
  end


  describe 'POST create' do
    context "for authenticated (signed in) users" do
      let(:current_user) { Fabricate(:user)  }
      let(:video)        { Fabricate(:video) }

      before do
        session[:user_id] = current_user.id
      end

      it "creates a valid queue item" do
        post :create, video_id: video.id
        expect(assigns(:queue_item)).to be_valid
      end
      it "loads the @video instance variable with the video" do
        post :create, video_id: video.id
        expect(assigns(:video)).to eq(video)
      end
      it "creates a new queue item associated with the user" do
        post :create, video_id: video.id
        expect(QueueItem.first.user_id).to eq(current_user.id)
      end
      it "creates a new queue item associated with the video" do
        post :create, video_id: video.id
        expect(QueueItem.first.video_id).to eq(video.id)
      end
      it "flashes an error message that video is already in the queue for duplicate attempts" do
        post :create, video_id: video.id
        expect(flash[:notice]).to_not be_nil
      end
      it "redirects to the MyQueue page" do
        post :create, video_id: video.id
        expect(response).to redirect_to my_queue_path
      end
      it "chooses the next position number in the list" do
        video1      = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: current_user, video: video1, position: 1)
        post :create, video_id: video.id
        expect(QueueItem.last.position).to eq(2)
      end
      it "does not allow duplicate videos in the queue" do
        queue_item = Fabricate(:queue_item, user: current_user, video: video)
        post :create, video_id: video.id
        expect(assigns(:queue_item)).to_not be_valid
      end
      it "flashes an error message that video is already in the queue for duplicate attempts" do
        queue_item = Fabricate(:queue_item, user: current_user, video: video)
        post :create, video_id: video.id
        expect(flash[:error]).to_not be_nil
      end
      it "redirects back to the video#show page after duplicate queue attempts" do
        queue_item = Fabricate(:queue_item, user: current_user, video: video)
        post :create, video_id: video.id
        expect(response).to redirect_to video_path(video)
      end
      it "reorders the positions prior to creation of the new position" do
        video1      = Fabricate(:video)
        video2      = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: current_user, video: video1, position: 3)
        queue_item2 = Fabricate(:queue_item, user: current_user, video: video2, position: 12)
        post :create, video_id: video.id
        expect(current_user.queue_items.map(&:position)).to eq([1,2,3])
      end
    end

    context "for UNauthenticated users (guests)" do
      it "redirects to the signin page" do
        session[:user_id] = nil
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(response).to redirect_to signin_path
      end
    end
  end

  describe 'DELETE destroy' do
    context "for authenticated (signed in) users" do
      let(:current_user) { Fabricate(:user ) }
      before { session[:user_id] = current_user.id }

      it "redirects if the current user is not the owner of the queue item" do
        other_user = Fabricate(:user)
        video      = Fabricate(:video)
        queue_item = Fabricate(:queue_item, video: video, user: other_user)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to root_path
      end
      it "deletes the clicked queue" do
        video      = Fabricate(:video)
        queue_item = Fabricate(:queue_item, video: video, user: current_user)
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq(0)
      end
      it "reorders the queue item positions" do
        video1      = Fabricate(:video)
        video2      = Fabricate(:video)
        video3      = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: current_user, video: video1, position: 1)
        queue_item2 = Fabricate(:queue_item, user: current_user, video: video2, position: 2)
        queue_item3 = Fabricate(:queue_item, user: current_user, video: video3, position: 3)
        delete :destroy, id: queue_item2.id
        expect(current_user.queue_items.map(&:position)).to eq([1,2])
      end
      it "redirects back to the queue page" do
        video      = Fabricate(:video)
        queue_item = Fabricate(:queue_item, video: video, user: current_user)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to my_queue_path
      end
    end

    context "for authenticated (signed in) users" do
      let(:user ) { Fabricate(:user  ) }
      let(:video) { Fabricate(:video ) }

      it "redirects to the signin page" do
        queue_item = Fabricate(:queue_item, video: video, user: user)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to signin_path
      end
    end
  end

  describe "POST update_queue" do
    let(:video1) { Fabricate(:video) }
    let(:video2) { Fabricate(:video) }
    let(:joe   ) { Fabricate(:user ) }

    before { session[:user_id] = joe.id  }

    context "with valid user inputs" do
      it "redirects back to the MyQueue page" do
        queue_item1 = Fabricate(:queue_item, user: joe, video: video1, position: 1)
        queue_item2 = Fabricate(:queue_item, user: joe, video: video2, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 4}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end
      it "reorders the positions ascending" do
        queue_item1 = Fabricate(:queue_item, user: joe, video: video1, position: 1)
        queue_item2 = Fabricate(:queue_item, user: joe, video: video2, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 4}, {id: queue_item2.id, position: 1}]
        expect(joe.queue_items.map(&:position)).to eq(joe.queue_items.map(&:position).sort)
      end
      it "renumbers the positions from 1" do
        queue_item1 = Fabricate(:queue_item, user: joe, video: video1, position: 3)
        queue_item2 = Fabricate(:queue_item, user: joe, video: video2, position: 16)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 4}, {id: queue_item2.id, position: 1}]
        expect(joe.queue_items.reload.map(&:position)).to eq([1,2])
      end
      it "flashes a notice message of success" do
        queue_item1 = Fabricate(:queue_item, user: joe, video: video1, position: 1)
        queue_item2 = Fabricate(:queue_item, user: joe, video: video2, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 1}]
        expect(flash[:notice]).to_not be_nil
      end

      context "for the video rating selector" do
        it "creates a review-rating if the user selects a rating for an unrated video" do
          queue_item1 = Fabricate(:queue_item, user: joe, video: video1, position: 1)
          queue_item2 = Fabricate(:queue_item, user: joe, video: video2, position: 2)
          post :update_queue, queue_items: [{id: queue_item1.id, position: 1, rating: 3},
                                            {id: queue_item2.id, position: 2, rating: nil}]
          expect(joe.queue_items.first.rating).to eq(3)
        end
        it "updates a review-rating if the user selects a different rating from current" do
          review1     = Fabricate(:review, user: joe, video: video1, rating: 3)
          queue_item1 = Fabricate(:queue_item, user: joe, video: video1, position: 1)
          queue_item2 = Fabricate(:queue_item, user: joe, video: video2, position: 2)
          post :update_queue, queue_items: [{id: queue_item1.id, position: 1, rating: 1},
                                            {id: queue_item2.id, position: 2, rating: nil}]
          expect(joe.queue_items.first.rating).to eq(1)
        end
        it "does not create a new rating if 'blank' is selected" do
          queue_item1 = Fabricate(:queue_item, user: joe, video: video1, position: 1)
          queue_item2 = Fabricate(:queue_item, user: joe, video: video2, position: 2)
          post :update_queue, queue_items: [{id: queue_item1.id, position: 1, rating: 0},
                                            {id: queue_item2.id, position: 2, rating: nil}]
          expect(joe.queue_items.first.rating).to be_nil
        end
        it "flashes notice that the rating updates were successful"
          # Array of flash notices not yet implemented
      end
    end

    context "with invalid user inputs" do
      it "should redirect back to the MyQueue page" do
        queue_item1 = Fabricate(:queue_item, user: joe, video: video1, position: 2)
        queue_item2 = Fabricate(:queue_item, user: joe, video: video2, position: 1)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 4.3}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end
      it "does not reorder any of the positions for non-integers" do
        queue_item1 = Fabricate(:queue_item, user: joe, video: video1, position: 2)
        queue_item2 = Fabricate(:queue_item, user: joe, video: video2, position: 7)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 1.2}]
        expect(joe.queue_items.reload.map(&:position)).to eq([2,7])
      end
      it "abort & rollback for duplicate positions" do
        queue_item1 = Fabricate(:queue_item, user: joe, video: video1, position: 2)
        queue_item2 = Fabricate(:queue_item, user: joe, video: video2, position: 7)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 3}]
        expect(joe.queue_items.reload.map(&:position)).to eq([2,7])
      end
      it "flashes an error message regarding valid input requirments" do
        queue_item1 = Fabricate(:queue_item, user: joe, video: video1, position: 2)
        queue_item2 = Fabricate(:queue_item, user: joe, video: video2, position: 7)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 4.3}]
        expect(flash[:error]).to_not be_nil
      end
    end

    context "for UNauthenticated (guest) users" do
      it "should redirect to the signin page" do
        session[:user_id] = nil
        queue_item1 = Fabricate(:queue_item, user: joe, video: video1, position: 2)
        queue_item2 = Fabricate(:queue_item, user: joe, video: video2, position: 7)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 4}]
        expect(response).to redirect_to signin_path
      end
    end
  end
end













