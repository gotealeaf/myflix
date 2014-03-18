require 'spec_helper'

describe ReviewsController do

  describe "POST create" do
    let(:video) {video = Fabricate(:video)}
    context "with authenticated user" do
       let(:current_user) {Fabricate(:user)}
        before { session[:user_id] = current_user.id }
      context "with valid inputs" do
        before {post :create, review: Fabricate.attributes_for(:review),  video_id: video.id}
        
        it "redirects to the current video show page" do
          expect(response).to redirect_to video
        end
        it "sets @video for the current video" do
          expect(assigns(:video)).to eq video
        end

        it "creates a review for the displayed video" do
          expect(Review.count).to eq(1)
        end

        

        it "associates the review to the current user" do
          expect(Review.first.user).to eq current_user
        end


        
      end #context
    
      context "with invalid inputs" do
        before { post :create, review: {rating: 2},  video_id: video.id, user_id: session[:user_id]}
        it "flashes a notice about invalid input" do
          expect(flash[:danger]).to include("review")
        end
        it "does not create a review" do
          expect(Review.count).to eq(0)
        end
        it "re-renders the video/show page" do
          expect(response).to render_template 'videos/show'
        end

        it "sets @video" do
          expect(assigns(:video)).to eq video
        end
        it "sets @reviews" do
          review1 = Fabricate(:review, video: video)
          post :create, review: {rating: 2},  video_id: video.id, user_id: session[:user_id]
          expect(assigns(:reviews)).to match_array([review1])
        end

      end #context
    end #context auth user

    context "unauthenticated user" do
      it "redirects to sign-in path" do
          post :create, review: Fabricate.attributes_for(:review),  video_id: video.id
          expect(response).to redirect_to sign_in_path
      end
    end #context un-auth user
  end
end
