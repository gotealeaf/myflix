require 'spec_helper'

describe QueueItemsController do
  before do
    request.env["HTTP_REFERER"] = "http://fake.referal/id" unless request.nil? or request.env.nil?
  end

  describe 'GET #index' do
    context 'authorized user' do
      it 'sets @queue_items' do
        set_current_user
        queue_item1 = Fabricate(:queue_item, user: current_user)
        queue_item2 = Fabricate(:queue_item, user: current_user)
        get :index
        expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
      end
    end

    it_behaves_like 'an unauthenticated user' do
      let(:action) { get :index }
    end
  end

  describe 'POST #create' do
    context 'authorized user' do
      context 'with correct parameters' do
        let(:video) { Fabricate(:video) }

        before do
          set_current_user
          post :create, video_id: video.id
        end

        it 'creates a QueueItem that is associated with the user' do
          expect(QueueItem.first.user_id).to eq(current_user.id)
        end

        it 'creates a QueueItem that is associated with the video' do
          expect(QueueItem.first.video_id).to eq(video.id)
        end

        it 'sets success message' do
          expect(flash[:success]).not_to be_blank
        end

        it 'redirects to the previous page' do
          expect(response).to redirect_to(request.env["HTTP_REFERER"])
        end

        it 'assigns position automatically' do
          another_video = Fabricate(:video)
          post :create, video_id: another_video.id
          expect(QueueItem.find_by_user_and_video(current_user, another_video).position).to eq (2)
        end

        it 'does not add the same video twice' do
          post :create, video_id: video.id
          expect(QueueItem.count).to eq(1)
        end
      end

      context 'with incorrect parameters' do
        before do
          set_current_user
          post :create
        end

        it 'does not create a QueueItem' do
          expect(QueueItem.count).to eq(0)
        end

        it 'redirects to the previous page' do
          expect(response).to redirect_to(request.env["HTTP_REFERER"])
        end

        it 'sets error message' do
          expect(flash[:danger]).not_to be_blank
        end
      end
    end

    it_behaves_like 'an unauthenticated user' do
      let(:action) { post :create, video_id: 1 }
    end
  end

  describe 'POST #destroy' do
    let(:video) { Fabricate(:video) }
    let(:queue_item) { Fabricate(:queue_item, video: video, user: current_user) }

    context 'authorized user' do
      before do
        set_current_user
      end

      context 'user owns QueueItem' do
        before do
          post :destroy, id: queue_item.id
        end

        it 'destroys the QueueItem with the provided id' do
          expect(QueueItem.count).to eq(0)
        end

        it 'redirects to the previous page' do
          expect(response).to redirect_to(request.env['HTTP_REFERER'])
        end

        it 'sets success message' do
          expect(flash[:success]).not_to be_blank
        end
      end

      context 'user does not own QueueItem' do
        before do
          queue_item.reload
          session[:user_id] = Fabricate(:user).id
          post :destroy, id: queue_item.id
        end

        it "does not destroy the QueueItem if it is not in the current user's queue" do
          expect(QueueItem.count).to eq(1)
        end

        it 'redirects to the previous page' do
          expect(response).to redirect_to(request.env['HTTP_REFERER'])
        end

        it 'sets error message' do
          expect(flash[:danger]).not_to be_blank
        end
      end
    end

    it_behaves_like 'an unauthenticated user' do
      let(:action) { post :destroy, id: 1 }
    end
  end

  describe 'PATCH #update_queue' do
    before do
      request.env["HTTP_REFERER"] = "http://fake.referal/id" unless request.nil? or request.env.nil?
    end

    context 'authorized user' do
      let!(:user) { Fabricate(:user) }
      let!(:video1) { Fabricate(:video) }
      let!(:video2) { Fabricate(:video) }
      let!(:queue_item1) { Fabricate(:queue_item, video: video1, position: QueueItem.next_available_position(user), user: user, created_at: 1.day.ago) }
      let!(:queue_item2) { Fabricate(:queue_item, video: video2, position: QueueItem.next_available_position(user), user: user) }

      before do
        session[:user_id] = user.id
      end

      context 'with valid position parameters' do
        it 'changes the order of videos in the queue' do
          post :update_queue, queue_items: [{id: queue_item1.id, position: 2, rating: ''}, {id: queue_item2.id, position: 1, rating: ''}]
          expect(queue_item1.reload.position).to eq(2)
          expect(queue_item2.reload.position).to eq(1)
        end

        it 'breaks video order ties automatically' do
          post :update_queue, queue_items: [{id: queue_item1.id, position: 1, rating: ''}, {id: queue_item2.id, position: 1, rating: ''}]
          expect(queue_item1.reload.position).to eq(2)
          expect(queue_item2.reload.position).to eq(1)
        end

        it 'does not change queue position if user does not own queue item' do
          set_current_user
          post :update_queue, queue_items: [{id: queue_item1.id, position: 3, rating: ''}]
          expect(queue_item1.reload.position).to eq(1)
        end

        it 'repositions queue items in order to fill any holes' do
          post :update_queue, queue_items: [{id: queue_item2.id, position: 3, rating: ''}, {id: queue_item1.id, position: 4, rating: ''}]
          expect(queue_item1.reload.position).to eq(2)
          expect(queue_item2.reload.position).to eq(1)
        end

        it 'sets success message' do
          post :update_queue, queue_items: [{id: queue_item2.id, position: 2, rating: ''}, {id: queue_item1.id, position: 4, rating: ''}]
          expect(flash[:success]).not_to be_blank
        end

        it 'redirects to previous page' do
          post :update_queue, queue_items: [{id: queue_item2.id, position: 1, rating: ''}, {id: queue_item1.id, position: 2, rating: ''}]
          expect(response).to redirect_to(request.env['HTTP_REFERER'])
        end
      end

      context 'with invalid position parameters' do
        it 'does not alter the positions of items in the queue' do
          post :update_queue, queue_items: [{id: queue_item1.id, position: '0.7', rating: ''}, {id: queue_item2.id, position: '1.7', rating: ''}]
          expect(queue_item1.reload.position).to eq(1)
          expect(queue_item2.reload.position).to eq(2)
        end

        it 'sets an error message' do
          post :update_queue, queue_items: [{id: queue_item1.id, position: '0.7', rating: ''}, {id: queue_item2.id, position: '1.7', rating: ''}]
          expect(flash[:danger]).not_to be_blank
        end

        it 'redirects to previous page' do
          post :update_queue, queue_items: [{id: queue_item1.id, position: '0.7', rating: ''}, {id: queue_item2.id, position: '1.7', rating: ''}]
          expect(response).to redirect_to(request.env['HTTP_REFERER'])
        end

        it 'does not make any changes if any positions are invalid' do
          queue_item3 = Fabricate(:queue_item, user: user, position: QueueItem.next_available_position(user))
          post :update_queue, queue_items: [{id: queue_item1.id, position: '0.7', rating: ''}, {id: queue_item2.id, position: '3', rating: ''}, {id: queue_item3.id, position: '2', rating: ''}]
          expect(queue_item2.reload.position).to eq(2)
        end
      end

      context 'with valid rating parameters' do
        let!(:review) { Fabricate(:review, rating: 3, creator: user, video: video1) }

        it 'updates existing review ratings' do
          review2 = Fabricate(:review, rating: 3, creator: user, video: video2)
          post :update_queue, queue_items: [{id: queue_item1.id, position: '1', rating: '1'}, {id: queue_item2.id, position: '2', rating: '2'}]
          expect(review.reload.rating).to eq(1)
          expect(review2.reload.rating).to eq(2)
        end

        it 'creates new, blank reviews for any previously unreviewed videos' do
          post :update_queue, queue_items: [{id: queue_item2.id, position: '2', rating: '2'}]
          expect(Review.find_rating_by_creator_and_video(user, video2)).to eq(2)
        end

        it 'sets success message' do
          post :update_queue, queue_items: [{id: queue_item2.id, position: '2', rating: '2'}]
          expect(flash[:success]).not_to be_blank
        end

        it 'redirects to the previous page' do
          post :update_queue, queue_items: [{id: queue_item2.id, position: '2', rating: '2'}]
          expect(response).to redirect_to(request.env['HTTP_REFERER'])
        end
      end
    end

    it_behaves_like 'an unauthenticated user' do
      let(:action) do
        post :update_queue, queue_items: [{id: 1, position: '2', rating: '2'}]
      end
    end
  end
end
