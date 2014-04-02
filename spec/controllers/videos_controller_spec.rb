require 'spec_helper'

describe VideosController do
  let(:video) { Fabricate(:video) }
  let(:user ) { Fabricate(:user ) }
  let(:user1) { Fabricate(:user ) }

  describe "GET #show" do

    it "redirects to root if user is not signed in" do
      session[:user_id] = nil
      get :show, id: user.id
      expect(response).to redirect_to signin_path
    end

    context "WITH signed-in user" do
      before { session[:user_id] = user.id }

      it "loads the @video variable" do
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end
      #IS THIS AN ISSUE WITH THE SETUP OF MY FABRICATION?
      it "indexes reviews in reverse chronological order" do
        review1 = Fabricate(:review, video: video, user: user  )
        review2 = Fabricate(:review, video: video, user: user1 )
        get :show, id: video.id
        expect(assigns(:video).reviews).to match_array([review1, review2])
      end
      it "renders the videos#show template" do
        get :show, id: video.id
        expect(response).to render_template :show
      end
    end
  end

  describe "GET #search" do

    it "redirects to root if user is not signed in" do
      session[:user_id] = nil
      get :search, search: "thing"
      expect(response).to redirect_to signin_path
    end

    context "WITH signed-in user" do
      before { session[:user_id] = user.id }

      it "loads @results with the return array of the title search" do
        get :search, search: video.title
        expect(assigns(:results)).to eq([video])
      end
      it "loads @searchtext with the user's search string" do
        get :search, search: "avideo"
        expect(assigns(:searchtext)).to eq("avideo")
      end
      it "renders the videos#search template" do
        get :search, search: video.title
        expect(response).to render_template :search
      end
    end
  end
end



