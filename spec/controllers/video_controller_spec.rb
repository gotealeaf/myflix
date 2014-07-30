require 'spec_helper'

describe VideosController do
  describe "GET show" do
    it "sets @video for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end
  
    it "sets @review for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review = Review.new
      get :show, id: video.id
      expect(assigns(:review)).to be_a_new(Review)
    end

    it "redirects the user to the sign-in page for unauthenticated users" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST search" do
    it "sets @videos_searched for one video for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      monk = Fabricate(:video, title: 'Monk')
      post :search, search_term: "mon"
      expect(assigns(:videos_searched)).to eq([monk])
    end

    # already tested permutations of matches in model spec so
    # dont really need this or others
    it "sets @videos_searched for multiple videos" do
      session[:user_id] = Fabricate(:user).id
      monk = Fabricate(:video, title: 'Monk')
      iron_monkey = Fabricate(:video, title: 'Iron Monkey')
      post :search, search_term: "mon"
      expect(assigns(:videos_searched)).to eq([iron_monkey, monk])
    end

    it "redirects to sign-in page for unauthenticated users" do
      iron_monkey = Fabricate(:video, title: 'Iron Monkey')
      post :search, search_term: "mon"
      expect(response).to redirect_to sign_in_path
    end

  end

end