require 'spec_helper'

describe VideosController do
  before { set_current_user }

  describe "GET index" do
    it "sets @categories to all categories" do
      get :index
      expect(assigns(:categories)).to eq Category.all
    end

    it_behaves_like "require_sign_in" do
      let(:action) { get :index }
    end
  end

  describe "GET show" do
    let(:video) { Fabricate(:video) }
    let(:review_1) { Fabricate(:review, user: current_user, video: video, rating: 3) }
    let(:review_2) { Fabricate(:review, user: current_user, video: video, rating: 3) }
    let(:review_3) { Fabricate(:review, user: current_user, video: video, rating: 4) }
    let(:action) { get :show, id: video.id }

    it "sets @reviews to the current video's reviews" do
      review_1; review_2; review_3
      action
      expect(assigns(:reviews)).to match_array [review_1, review_2, review_3]
    end

    it "sets @video to the current video" do
      action
      expect(assigns(:video)).to eq(video)
    end

    it "sets @average_rating rounded 1 place if there are reviews for the video" do
      review_1; review_2; review_3
      action
      expect(assigns(:average_rating)).to eq(3.3)
    end

    it "sets @average_rating if there are no reviews for the video" do
      action
      expect(assigns(:average_rating)).to eq("Not yet reviewed.")
    end

    it_behaves_like "require_sign_in" do
      let(:action) { get :show, id: video.id }
    end
  end

  describe "GET search" do
    it "sets @results to the search term param" do
      futurama = Fabricate(:video, title: "Futurama")
      get :search, search_term: "futurama"
      expect(assigns(:results)).to eq [futurama]
    end

    it_behaves_like "require_sign_in" do
      let(:action) { get :search, search_term: "futurama" }
    end
  end
end