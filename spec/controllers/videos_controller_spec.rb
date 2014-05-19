require 'spec_helper'

describe VideosController do
  let(:video) {Fabricate(:video)}
  
  context "for an authenticated user" do
    before do
      user = Fabricate(:user)
      session[:user_id] = user.id
    end

    describe "GET #index" do
      it "assigns @catgories" do
        get :index
        expect(assigns(:categories)).to eq(Category.all)      
      end
      it "renders the index page" do
        get :index
        expect(response).to render_template(:index)
      end
      
    end
    
    describe "GET #show" do
      it "assigns @video" do
        get :show, id: video
        expect(assigns(:video)).to eq(video)      
      end
      it "renders the show page" do
        get :show, id: video
        expect(response).to render_template(:show)
      end
      context "for video with reviews" do
        let(:review1) {Fabricate(:review, video: video, created_at: 1.day.ago)}
        let(:review2) {Fabricate(:review, video: video)}
        it "assigns @reviews" do
          get :show, id: video
          expect(assigns(:reviews)).to eq(video.reviews)      
        end
        it "presents reviews by created_at in desending order" do
          get :show, id: video
          expect(assigns(:reviews)).to eq([review2, review1])
        end
      end
    end
  
    describe "GET #search" do
      it "assigns @videos" do
        get :search, search_term: video.title
        expect(assigns(:videos)).to eq([video])      
      end
      it "renders the search page" do
        get :search, search_term: video.title
        expect(response).to render_template(:search)
      end
    end
  end
  
  context "for an unauthenticated user" do
    describe "GET #index" do
      it "redirects to the sign in page" do
        get :index
        expect(response).to redirect_to(sign_in_path)
      end
    end

    describe "GET #show" do
      it "redirects to the sign in page" do
        get :show, id: video
        expect(response).to redirect_to(sign_in_path)
      end
    end

    describe "GET #search" do
      it "redirects to the sign in page" do
        get :search, search_term: video.title
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end
  
end