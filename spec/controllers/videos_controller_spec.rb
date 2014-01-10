require 'spec_helper'

describe VideosController do
  before do
    my_user = User.create(email: 'jlevinger@jtonedesigns.com', password: 'joelevinger', full_name: 'Joe Levinger')
    session[:user_id] = my_user.id
  end
  describe 'POST search' do
    it "returns videos" do
      video = Video.create(title: "Che", description: "great video")
      post :search, search_term: 'Che'
      expect(assigns(:videos)).to eq([video])
    end

    it "renders search" do
      video = Video.create(title: "Che", description: "great video")
      post :search, search_term: 'Che'
      expect(response).to render_template :search
    end

    it "redirects to root if not logged in" do
      session[:user_id] = nil
      video = Video.create(title: "Che", description: "great video")
      post :search, search_term: 'Che'
      expect(response).to redirect_to root_path
    end
  end
end