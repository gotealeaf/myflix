require 'spec_helper'

describe VideosController do


  let(:user)  { Fabricate(:user) }
  let(:video) { Fabricate(:video) }

  describe "videos#show" do
    it "assigns specific video to video by id when logon" do
      set_current_user
      get :show, id: video.id
      expect(assigns(:video)).to eq video
    end
    it_behaves_like "require_sign_in" do
      let(:action) { get :show, id: video.id }
    end
  end  

  describe "videos#search" do
    it "assigns specific videos to @videos by search_item" do
      set_current_user
      get :search, search_item: video.title 
      expect(assigns(:videos)).to eq [video]
    end
    it_behaves_like "require_sign_in" do
      let(:action) {get :search, search_item: video.title}
    end 
  end


end
