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
    it "sets @video" do
      bob = Fabricate(:user, admin: true)
      set_current_user(bob)
      get :new

      expect(assigns(:video)).to be_a Video
    end

    it "sets @category" do
      bob = Fabricate(:user, admin: true)
      set_current_user(bob)
      get :new

      expect(assigns(:category)).to be_a Category
    end
  end

  describe "POST create" do
    context "with valid input" do
      it "makes a video" do
        bob = Fabricate(:user, admin: true)
        set_current_user(bob)

        post :create, video: Fabricate.attributes_for(:video)
        expect(Video.count).to eq(1)
      end
      it "redirects to the category index" do
        bob = Fabricate(:user, admin: true)
        set_current_user(bob)
        post :create, video: Fabricate.attributes_for(:video)

        video = Video.first
        expect(response).to redirect_to(category_path(video.category.id))
      end
    end
    context "with invalid input" do

      it "does not add a video record" do
        bob = Fabricate(:user, admin: true)
        set_current_user(bob)
        post :create, video: {title: "invalid video"}

        expect(Video.count).to eq(0)
      end
      it "renders the new template" do
        bob = Fabricate(:user, admin: true)
        set_current_user(bob)
        post :create, video: {title: "invalid video"}

        expect(response).to render_template(:new)
      end
      it "shows error messages" do
        bob = Fabricate(:user, admin: true)
        set_current_user(bob)
        post :create, video: {title: "invalid video"}
        expect(flash[:notice]).to eq("Invalid inputs. Please try again.")
      end

      it "sets @video" do
        bob = Fabricate(:user, admin: true)
        set_current_user(bob)
        post :create, video: {title: "invalid video"}

        expect(assigns(:video)).to be_a Video
      end
    end
  end
end