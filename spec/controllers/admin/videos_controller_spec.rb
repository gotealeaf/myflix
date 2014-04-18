require 'spec_helper'

describe Admin::VideosController do
  describe "GET new" do
    it "renders the new template for creating a video" do
      bob = Fabricate(:user, admin: true)
      set_current_user(bob)
      get :new

      expect(response).to render_template(:new)
    end
    it "only renders this page for admins" do
      bob = Fabricate(:user, admin: false)
      set_current_user(bob)
      get :new

      expect(response).to redirect_to(videos_path)
    end
    it "sets @video"
  end
end