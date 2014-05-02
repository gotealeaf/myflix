require 'spec_helper'

describe ReviewsController do
  
  describe "POST create" do
    let(:video) { Fabricate(:video) }
    context "authenticated user" do
      let(:current_user) { Fabricate(:user) }
     
      context "with valid input" do
        before do
          session[:user_id] = current_user.id
          post :create, video_id: video.id, review: Fabricate.attributes_for(:review)
        end   
        
        it "should create a review" do
          expect(Review.count).to eq(1)
        end   
        it "should create a review associated with the current user" do
          expect(Review.first.user).to eq(current_user)
        end
        it "should create a review associated with the video" do
          expect(Review.first.video).to eq(video)
        end
        it "should set the @video instance variable" do
          expect(assigns(:video)).to eq(video)
        end
        it "should redirect to the video show page if saved" do
          response.should redirect_to video_path(video)
        end
        it "should display success message if saved" do
          expect(flash[:success]).to eq("Your review was added.")
        end
      end #ends valid input context
        
      context "with invalid input" do
        before do
          session[:user_id] = current_user.id
          post :create, video_id: video.id, review: { rating: 4 }
        end
        it "should not create a review" do
          expect(Review.count).to eq(0)
        end
        it "should render the videos show template if review not saved" do
          response.should render_template "videos/show"
        end
        it "should display the error message if review not saved" do
          expect(flash[:danger]).to eq("Your review could not be saved at this time.")
        end
      end #ends with invalid input context 
    end #ends authenticated user context
    
    context "unauthenticated user" do
      before do
        post :create, video_id: video.id, review: Fabricate.attributes_for(:review)
      end
      it "should redirect to the root path" do
        response.should redirect_to root_path
      end
      it "should display an error message" do
        expect(flash[:danger]).not_to be_blank
      end
    end #ends unauthenticated user context
  end #ends POST create
end #ends ReviewsController