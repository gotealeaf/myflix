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
end
