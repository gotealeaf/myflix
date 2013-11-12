require 'spec_helper'

describe VideosController do
  describe "GET show" do
    it "sets @video with authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end
  end
end