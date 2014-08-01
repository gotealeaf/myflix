require 'rails_helper'

describe VideosController do
  describe "GET show" do
    context "with authenticated user" do
      before do
        user = Fabricate(:user)
        session[:user_id] = Fabricate(:user).id
      end

      it "sets @video" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(assigns(:video)).to eql(video)
      end
    
      it "renders the show template"
    end
  end
end