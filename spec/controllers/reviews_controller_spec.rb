require 'spec_helper'

describe ReviewsController do
  describe 'POST #create' do
    it_behaves_like 'an unauthenticated user' do
      let(:action) { post :create, video_id: 1, review: {body: '', rating: 1}}
    end

    context 'user logged in' do
      before do
        set_current_user
      end

      context 'with valid parameters' do
        let(:video) { Fabricate(:video) }
        before do
          post :create, video_id: video.id, review: Fabricate.attributes_for(:review)
        end

        it 'creates review' do
          expect(Review.first.video).to eq(video)
        end

        it 'expects review to be associated with signed in user' do
          expect(Review.first.creator).to eq(current_user)
        end

        it 'redirects to show video path' do
          expect(response).to redirect_to(video_path(video))
        end

        it 'sets success message' do
          expect(flash[:success]).not_to be_blank
        end
      end

      context 'with invalid parameters' do
        let(:video) { Fabricate(:video) }
        let(:review) { Fabricate.build(:review) }
        before do
          review['body']    = nil
          post :create, video_id: video.id, review: review.attributes
        end

        it 'sets @video' do
          expect(assigns(:video)).to eq(video)
        end

        it 'sets @review' do
          expect(assigns(:review).body).to eq(review.body)
        end

        it 'does not create review' do
          expect(Review.count).to eq(0)
        end

        it 'renders the videos#show template' do
          expect(response).to render_template('videos/show')
        end

        it 'sets error message' do
          expect(flash[:danger]).not_to be_blank
        end
      end
    end
  end
end
