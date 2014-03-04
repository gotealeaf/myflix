require 'spec_helper'

describe VideosController do 
  
  describe "GET show" do
    it "sets the @video variable" do
      session[:user_id] = Fabricate(:user).id
      south_park = Fabricate(:video)

      get :show, id: 1
      expect(assigns(:video)).to eq(south_park)
    end
    it "renders the show template" do
      session[:user_id] = Fabricate(:user).id
      south_park = Fabricate(:video)
      get :show, id: 1
      expect(response).to render_template :show
    end
  end
end