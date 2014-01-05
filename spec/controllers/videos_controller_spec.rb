require 'spec_helper'

describe VideosController do
  describe 'POST search' do
    it "returns videos" do
      Video.delete_all
      video = Video.create(title: "Che", description: "great video")
      post :search, search_term: 'Che'
      expect(assigns(:videos)).to eq([video])
    end

    it "renders search" do
      Video.delete_all
      video = Video.create(title: "Che", description: "great video")
      post :search, search_term: 'Che'
      expect(response).to render_template :search
    end
  end
end