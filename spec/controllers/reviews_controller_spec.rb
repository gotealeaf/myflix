require 'spec_helper'

describe ReviewsController do
  describe 'POST #create' do
    context 'user not logged in' do
      let(:video) { Fabricate(:video) }
      let(:review) { Fabricate.build(:review) }
      before do
        review['body'] = nil
        post :create, video_id: video.id, review: review.attributes
      end

      it 'redirects to sign in page' do
        expect(response).to redirect_to(sign_in_path)
      end

      it 'sets warning message' do
        expect(flash[:info]).not_to be_blank
      end
    end

    context 'user logged in' do
      context 'with valid parameters' do
        let(:user) { Fabricate(:user) }
        let(:video) { Fabricate(:video) }
        before do
          session[:user_id] = user.id
          post :create, video_id: video.id, review: Fabricate.attributes_for(:review)
        end

        it 'creates review' do
          expect(Review.first.video).to eq(video)
        end

        it 'expects review to be associated with signed in user' do
          expect(Review.first.creator).to eq(user)
        end

        it 'redirects to show video path' do
          expect(response).to redirect_to(video_path(video))
        end

        it 'sets success message' do
          expect(flash[:success]).not_to be_blank
        end
      end

      context 'with invalid parameters' do
        let(:user) { Fabricate(:user) }
        let(:video) { Fabricate(:video) }
        let(:review) { Fabricate.build(:review) }
        before do
          review['body']    = nil
          session[:user_id] = user.id
          post :create, video_id: video.id, review: review.attributes
        end

        it 'does not create review' do
          expect(Review.count).to eq(0)
        end

        it 'redirects to show video path' do
          expect(response).to redirect_to(video_path(video))
        end

        it 'sets error message' do
          expect(flash[:danger]).not_to be_blank
        end
      end
    end
  end
end
