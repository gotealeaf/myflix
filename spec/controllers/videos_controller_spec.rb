require 'spec_helper'

describe VideosController do 
  describe "GET show" do
    context "with authenticated users" do
      before do
        session[:user_id] = Fabricate(:user).id
      end
      let(:video) { Fabricate(:video) }

      it "sets the @video variable based on id" do
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end

      it "sets the @review variable to Review.new" do
        get :show, id: video.id
        expect(assigns(:review)).to be_new_record
        expect(assigns(:review)).to be_instance_of(Review)
      end

      context "no reviews" do
        it "sets the @reviews variable to an empty array" do
          get :show, id: video.id
          expect(assigns(:reviews)).to eq([])
        end
      end

      context "one review" do
        it "sets the @reviews variable to an array contain the review" do
          review = Fabricate(:review, user_id: 1, video_id: 1)
          get :show, id: video.id
          expect(assigns(:reviews)).to eq([review])
        end
      end

      context "several reviews" do
        it "sets the @reviews variable to a list of reviews for the video, most recent first" do
          review_1 = Fabricate(:review, user_id: 1, video_id: 1)
          review_2 = Fabricate(:review, user_id: 1, video_id: 1)
          review_3 = Fabricate(:review, user_id: 1, video_id: 1)
          get :show, id: video.id
          expect(assigns(:reviews)).to eq([review_3, review_2, review_1])
        end
      end

      # can get rid of this - not testing our code, rails convention
      # note that if you cut this, should probably eliminate context
      # just keeping it here for an example of that org. technique.
      it "renders the show template" do
        get :show, id: video.id
        expect(response).to render_template(:show)
      end
    end

    context "with unauthenticated users" do
      let(:video) { Fabricate(:video) }

      it "redirects to login page" do
        get :show, id: video.id
        expect(response).to redirect_to(:login)
      end

    end
  end

  describe "GET search" do
    context "with authenticated users" do
      before do
        session[:user_id] = Fabricate(:user).id
      end
      let(:futurama) { Fabricate(:video, title: "Futurama") }
      let(:videos) { Fabricate.times(4, :video) }

      # not necessary, already did this at the model level
      it "sets the @search_results variable if no results found" do
        get :search, search: "unmatched_search_bleah"
        expect(assigns(:search_results)).to eq([])
      end

      it "sets the @search results variable to a list of videos if results found" do
        get :search, search: "futurama"
        expect(assigns(:search_results)).to eq([futurama])
      end

      it "renders the search template" do
        get :search
        expect(response).to render_template(:search)
      end
    end

    it "redirects the user to the login page if not authenticated" do
      get :search, search: "futurama"
      expect(response).to redirect_to(:login)
    end
  end
end