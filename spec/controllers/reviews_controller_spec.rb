require 'rails_helper'

describe ReviewsController do
  describe 'POST create' do
    context 'with authenticated user' do

      let(:current_user) {Fabricate(:user)}
      let(:video) { Fabricate(:video)}
      before { session[:username] = current_user.username }

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
            expect(Review.first.user).to eq(current_user)
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
        it 'should redirect to the videos/show page' do
          expect(response).to render_template 'videos/show'
        end
        it 'assigns @video variable' do
          expect(assigns(:video)).to eq(video)
        end

        it 'assigns @review variable' do
          reviews = Fabricate(:review, user: current_user, video: video)
          expect(assigns(:reviews)).to match_array(reviews)
        end
      end

    end
    context "with unauthenticated user" do
      it 'should redirect to the sign in path' do
        video = Fabricate(:video)
        post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end
