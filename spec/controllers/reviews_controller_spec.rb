require 'spec_helper'

describe ReviewsController do
  describe 'POST create' do
    context 'with authenticated users' do
      let(:user) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      before do
        session[:user_id] = user.id
      end

      context 'with valid inputs' do
        it 'creates a review' do
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(Review.count).to eq(1)
        end
        it 'creates a review that associated with the video' do
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(Review.first.video).to eq(video)
        end
        it 'creates a review that associated with the signed in user' do
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id, user_id: user.id
          expect(Review.first.user).to eq(user)
        end
        it 'redirects user to video show page' do
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id, user_id: user.id
          expect(response).to redirect_to(video_path(video))
        end
      end

      context 'with invalid inputs' do
        it 'does not create a review' do
          post :create, review: {rating: 5}, video_id: video.id, user_id: user.id
          expect(Review.count).to eq(0)
        end
        it 'sets @video' do
          post :create, review: {rating: 5}, video_id: video.id, user_id: user.id
          expect(assigns(:video)).to eq(video)
        end
        it 'renders video show template' do
          post :create, review: {rating: 5}, video_id: video.id, user_id: user.id
          expect(response).to render_template('videos/show')
        end
        it 'sets error message' do
          post :create, review: {rating: 5}, video_id: video.id, user_id: user.id
          expect(flash[:danger]).not_to be_blank
        end
      end

    end

    context 'with unauthenticated users' do
      it 'redirects user to sign in page' do
        video = Fabricate(:video)
        post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        expect(response).to redirect_to sign_in_path
      end
    end

  end
end
