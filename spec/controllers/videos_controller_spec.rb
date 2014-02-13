require 'spec_helper'

describe VideosController do
  describe "GET show" do
    let(:video) { Fabricate(:video) }

    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: video.id }
    end

    it "sets the @video variable for authenticated users" do
      set_current_user
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "sets the @reviews variable for authenticated users" do
      set_current_user
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review1, review2])
    end
  end

  describe "POST search" do
    it_behaves_like "requires sign in" do
      let(:action) { post :search, search_term: 'rama' }
    end

    it "sets @results for authenticated users" do
      set_current_user
      futurama = Fabricate(:video, title: "Futurama")
      post :search, search_term: 'rama'
      expect(assigns(:results).first).to eq(futurama)
    end
  end
end
