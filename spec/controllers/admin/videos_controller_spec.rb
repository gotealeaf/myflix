require 'spec_helper'
  
describe Admin::VideosController do
  describe "GET new" do
    it "redirects to login page if no user" do
      get :new
      expect(response).to redirect_to login_path
    end

    it "redirects to home if user not admin" do 
      alice = Fabricate(:user, admin: false)
      set_current_user(alice)
      get :new
      expect(flash[:danger]).to eq("You do not have permission to do that.")
      expect(response).to redirect_to home_path
    end

    it "renders new video page if user is admin" do
      alice = Fabricate(:user, admin: true)
      set_current_user(alice)
      get :new
      expect(response).to render_template :new
    end
  end
end