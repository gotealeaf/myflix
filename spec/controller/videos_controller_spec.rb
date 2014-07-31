require 'rails_helper'

describe VideosController do
  it "GET show" do
    context "with authenticated user" do
      before do
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