require "spec_helper"

describe ReviewsController do
  describe "POST create" do
    before { set_current_user }
    let(:video) { Fabricate(:video) }

    context "with authenticated user" do
      context "with valid input" do
        before { post :create, review: Fabricate.attributes_for(:review), video_id: video.id }

        it "saves a new review to the database" do
          expect(Review.count).to eq(1)
        end

        it "creates a review associated with the video" do
          expect(Review.first.video).to eq(video)
        end

        it "creates a review associated with logged in user" do
          expect(Review.first.creator).to eq(current_user)
        end

        it "sends the notice" do
          expect(flash[:notice]).to_not be_blank
        end 

        it "redirects to videos/show page" do
          expect(response).to redirect_to video_path(video)
        end
      end

      context "with invalid input" do
        before { post :create, review: { rating: 4 }, video_id: video.id }

        it "does not save a new video to database" do
          expect(Review.count).to eq(0)
        end

        it "renders videos/show template" do
          expect(response).to render_template "videos/show"
        end
      end
    end
  end

  it_behaves_like "require_login" do
    let(:action) { post :create, review: Fabricate.attributes_for(:review), video_id: Fabricate(:video).id }
  end
end









