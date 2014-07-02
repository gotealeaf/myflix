require 'rails_helper'

describe QueueVideosController do
  describe 'GET Index' do
    context 'when user is authenticated' do
      let(:current_user) { Fabricate(:user) }
      it 'should assign @queue_videos variable' do
        user = current_user
        session[:username] = user.username
        queue_video1 = Fabricate(:queue_video, user: user)
        queue_video2 = Fabricate(:queue_video, user: user)
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
end
