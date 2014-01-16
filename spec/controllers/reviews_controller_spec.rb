require 'spec_helper'

describe ReviewsController do
  describe "POST   create" do
    let(:video) { Fabricate(:video)}
    context "with unauthenticated users" do
      it "redirects to the sign_in page" do
        post :create
        expect(response).to redirect_to sign_in_path
      end
    end
    context "with authenticated users" do
      let(:current_user) {Fabricate(:user)}
      before {session[:user_id]= current_user.id}
    
      # context "with invalid inputs" do
      #   before { post :create, review: {rating: 5}, video_id: video.id}
      #   it "sets the error message"
      #   it "renders the show page again"  do
      #     expect(response).to render_template 'video/show'
      #   end
      # end
    
     context "with valid inputs" do
      # before { post :create, review: {Fabricate(:review), video_id: video.id, user_id: current_user.id}}
      before { post :create, review: {rating: 4, content: "good"}

        it "redirects to the show page" do
          expect(response).to redirect_to video
        end
        it "creates a review"  do
          test_user = Fabricate(:user)
          expect(Review.count).to eq(1)
        end
    
        it "creates a review associated with the video"
        it "creats a review associated with signed in user"
      end
    end
  end
end
