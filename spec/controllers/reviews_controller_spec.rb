require 'spec_helper'

describe ReviewsController do
  describe "POST   create" do
    let(:video) { Fabricate(:video)}

    it_behaves_like "requires sign in" do
      let(:action) {post :create}
    end
     
    context "with authenticated users" do
      let!(:user1) {Fabricate(:user)}
      before {session[:user_id] = user1.id}

      context "with invalid inputs" do
        before { post :create, review: {rating: 5}, video_id: video.id}
        
        it "sets the error message" do
          expect(flash[:error]).not_to be_blank
        end
        it "renders the show page again"  do
          expect(response).to render_template 'videos/show'
        end
      end
    
     context "with valid inputs" do
      # before { post :create, review: {Fabricate(:review), video_id: video.id}
      before { post :create, review: {rating: 4, content: "good"}, video_id: video.id}

        it "redirects to the show page" do
          expect(response).to redirect_to video
        end
        it "creates a review"  do
          expect(Review.count).to eq(1)
        end
    
        it "creates a review associated with the video" do
          expect(Review.first.video).to eq(video)
        end
        it "creats a review associated with signed in user" do
          expect(Review.first.user).to eq(current_user)
        end
     end
    end
  end
end
