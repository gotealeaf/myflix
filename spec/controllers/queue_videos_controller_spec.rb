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
      it 'shoulds associate queue item to current user' do
        post :create, video_id: video.id
        expect(QueueVideo.first.user).to eq(current_user)
      end
      it 'should associate queue video to a video' do
        post :create, video_id: video.id
        expect(QueueVideo.first.video).to eq(video)
      end
      it 'should place the queue video at the bottom of the list' do
        Fabricate(:queue_video, video: video, user: current_user)
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
end
