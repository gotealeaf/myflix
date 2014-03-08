require 'spec_helper'
require 'pry'

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