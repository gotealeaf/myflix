require 'spec_helper'

describe VideosController do
  describe "GET show" do
    it "assign the requested video to @video" do
      video1 = Video.create(title: 'video1', description: 'video1 description')
      get :show, id: video1.id
      binding.pry
      expect(assigns(:video)).to eq(video1)
    end
    it "renders the show video page"
  end
end