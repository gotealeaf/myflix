require 'rails_helper'

describe QueueVideosController do
  describe 'GET Index' do
    context 'when user is authenticated' do

      let(:current_user) { Fabricate(:user) }

      it 'should assign @queue_videos variable' do
        user = current_user
        session[:username] = user.username
        queue_video1 = Fabricate(:queue_video, user: user)
        queue_video2 = Fabricate(:queue_video, video_id: 2, user: user)
        get :index
        expect(assigns(:queue_videos)).to match_array([queue_video1, queue_video2])
      end
    end

    context 'when user is unauthenticated' do
      it 'should redirect to sign in page' do
        get :index
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe 'POST Create' do
    context 'when user is authenticated' do

      let(:current_user) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }

      before do
        session[:username] = current_user.username
      end
      it 'should redirect to my queue page' do
        post :create, video_id: video.id
        expect(response).to redirect_to my_queue_path
      end
      it 'should create a queue video' do
        post :create, video_id: video.id
        expect(QueueVideo.count).to eq(1)
      end
      it 'should associate queue item to current user' do
        post :create, video_id: video.id
        expect(QueueVideo.first.user).to eq(current_user)
      end
      it 'should associate queue video to a video' do
        post :create, video_id: video.id
        expect(QueueVideo.first.video).to eq(video)
      end
      it 'should place the queue video at the bottom of the list' do
        Fabricate(:queue_video, video: video, user: current_user, position: 1)
        video_2 = Fabricate(:video)
        post :create, video_id: video_2.id
        video_2_position = QueueVideo.find_by(video_id: video_2.id).position
        expect(video_2_position).to eq(2)
      end
      it 'should not add video if already in queue' do
        Fabricate(:queue_video, video: video, user: current_user)
        post :create, video_id: video.id
        expect(QueueVideo.count).to eq(1)
      end
    end

    context 'when user is unauthenticated' do
      it 'should redirect to sign in page' do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(response).to redirect_to(:sign_in)
      end
    end
  end

  describe 'DELETE Destroy' do
    context 'when user is authenticated' do

      let(:current_user) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_video) { Fabricate(:queue_video, video: video, user: current_user) }
      before do
        session[:username] = current_user.username
      end
      it 'should redirect to my queue' do
        delete :destroy, id: queue_video.id
        expect(response).to redirect_to my_queue_path
      end
      it 'should delete selected video from queue' do
        delete :destroy, id: queue_video.id
        expect(QueueVideo.count).to eq(0)
      end
      it 'should not delete video from queue if not the users queue' do
        user = Fabricate(:user)
        queue_video = Fabricate(:queue_video, user: user, video: video)
        delete :destroy, id: queue_video.id
        expect(QueueVideo.count).to eq(1)
      end
      it 'should normalise the position numbers' do
        queue_video_1 = Fabricate(:queue_video, position: 1, user: current_user, video: video)
        queue_video_2 = Fabricate(:queue_video, position: 2, user: current_user, video: video)
        queue_video_3 = Fabricate(:queue_video, position: 3, user: current_user, video: video)
        delete :destroy, id: queue_video_1.id
        expect(QueueVideo.find(queue_video_2.id).position).to eq(1)
      end
    end
    context 'when user is unauthenticated' do
      it 'should redirect to sign in page' do
        queue_video = Fabricate(:queue_video)
        delete :destroy, id: queue_video.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe 'POST update_queue' do
    context 'when user is authenticated' do

      let(:user) { Fabricate(:user) }
      before do
        session[:username] = user.username
        @queue_video_1 = Fabricate(:queue_video, position: 1, user: user)
        @queue_video_2 = Fabricate(:queue_video, position: 2, user: user)
      end

      it 'should redirect to my queue page' do
        post :update_queue, queue_videos: [{id: @queue_video_1.id, position: 2}, {id: @queue_video_2.id, position: 1}]
        expect(response).to redirect_to(:my_queue)
      end
      it 'should update the position of queue videos' do
        post :update_queue, queue_videos: [{id: @queue_video_1.id, position: 2}, {id: @queue_video_2.id, position: 1}]
        expect(user.queue_videos).to eq([@queue_video_2, @queue_video_1])
      end
      it 'should normalise the position numbers' do
        post :update_queue, queue_videos: [{id: @queue_video_1.id, position: 3 }]
        expect(user.queue_videos.map(&:position)).to eq([1,2])
      end

      context 'with invalid non integer inputs' do
        it 'should redirect to my queue page' do
          post :update_queue, queue_videos: [{id: @queue_video_1.id, position: 2.5}, {id: @queue_video_2.id, position: 1}]
          expect(response).to redirect_to my_queue_path
        end
        it 'should flash an error message' do
          post :update_queue, queue_videos: [{id: @queue_video_1.id, position: 2.5}, {id: @queue_video_2.id, position: 1}]
          expect(flash[:danger]).to be_present
        end
        it 'should not update the position of queue videos' do
          post :update_queue, queue_videos: [{id: @queue_video_1.id, position: 3}, {id: @queue_video_2.id, position: 2.5}]
          expect(@queue_video_1.reload.position).to eq(1)
        end
      end
    end

    context 'when user is unauthenticated' do
      it 'should redirect_to sign in page' do
        post :update_queue
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end
