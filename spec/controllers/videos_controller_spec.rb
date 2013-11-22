require 'spec_helper'

describe VideosController do
  describe "GET show" do
    it "sets @video with authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "sets @reviews to all reviews for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      expect(assigns(:reviews)).to eq([review2, review1])
    end

    it "sets @average_rating to be the average of all review ratings" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      expect(assigns(:average_rating)).to eq(((review1.rating+review2.rating)/2.round(2)))
    end
  end
  
  describe "POST search" do
    it "sets @results for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video1 = Fabricate(:video, name: "Joe")
      
      post :search, search: 'Joe'
      expect(assigns(:results)).to eq([video1])
    end
  end
end