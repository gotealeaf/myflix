require 'rails_helper'

describe ReviewsController do
  describe 'POST create' do
    context 'with authenticated user' do

      before { set_session_user }

      context 'if validations pass' do
        before do
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        end
          it 'redirects to show page' do
            expect(response).to redirect_to video_path(video)
          end
          it 'creates a review' do
            expect(Review.count).to eq(1)
          end
          it 'creates a review associated with the video' do
            expect(Review.first.video).to eq(video)
          end
          it 'creates a review associated with the user' do
            expect(Review.first.user).to eq(user)
          end
          it 'flashes a success message' do
            expect(flash[:success]).to eq("Thanks! Your review has been posted!")
          end
      end

      context 'if validations fail' do
        before { post :create, review: { rating: 5 }, video_id: video.id }
        it 'should not create a review' do
          expect(Review.count).to eq(0)
        end
        it 'should render the videos/show page' do
          expect(response).to render_template 'videos/show'
        end
        it 'assigns @video variable' do
          expect(assigns(:video)).to eq(video)
        end

        it 'assigns @review variable' do
          reviews = Fabricate(:review, user: user, video: video)
          expect(assigns(:reviews)).to match_array(reviews)
        end
      end

    end

    it_behaves_like 'redirect for unauthenticated user' do
      let(:action) { post :create, review: Fabricate.attributes_for(:review), video_id: video.id }
    end
  end
end
