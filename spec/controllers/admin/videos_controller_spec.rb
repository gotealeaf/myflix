require 'spec_helper'

describe Admin::VideosController do
  describe "GET new" do
    it "renders the new template for creating a video" do
      get :new
      expect(response).to render_template(:new)
    end
    it "only renders this page for admins" do
      alice = Fabricate(:user, admin: true)
      
    end
    it "sets @video"
  end
end