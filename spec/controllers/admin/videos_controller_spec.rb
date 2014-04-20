require 'spec_helper'

describe Admin::VideosController do
  describe "GET new" do
    it "renders the new template for creating a video" do
      set_current_admin
      get :new

      expect(response).to render_template(:new)
    end
    it "only renders this page for admins" do
      set_current_user
      get :new

      expect(response).to redirect_to(videos_path)
    end
    it "sets @video to a new video" do
      set_current_admin
      get :new

      expect(assigns(:video)).to be_a Video
    end

    it "redirects the regular user to the home path" do
      set_current_user
      get :new

      expect(response).to redirect_to(videos_path)
    end
    it "sets the flash error message for regular users" do
      set_current_user
      get :new

      expect(flash[:notice]).to eq("Access denied.")
    end
    it "requires the user to sign in" do
      get :new
      expect(response).to redirect_to(sign_in_path)
    end
  end

  describe "POST create" do
    context "with valid input" do
      it "makes a video" do
        set_current_admin

        post :create, video: Fabricate.attributes_for(:video)
        expect(Video.count).to eq(1)
      end
      it "redirects to the category index" do
        set_current_admin
        post :create, video: Fabricate.attributes_for(:video)

        video = Video.first
        expect(response).to redirect_to(category_path(video.category.id))
      end
    end
    context "with invalid input" do

      it "does not add a video record" do
        set_current_admin
        post :create, video: {title: "invalid video"}

        expect(Video.count).to eq(0)
      end
      it "renders the new template" do
        set_current_admin
        post :create, video: {title: "invalid video"}

        expect(response).to render_template(:new)
      end
      it "shows error messages" do
        set_current_admin
        post :create, video: {title: "invalid video"}
        expect(flash[:notice]).to eq("Invalid inputs. Please try again.")
      end

      it "sets @video" do
        set_current_admin
        post :create, video: {title: "invalid video"}

        expect(assigns(:video)).to be_a Video
      end
    end
  end
end