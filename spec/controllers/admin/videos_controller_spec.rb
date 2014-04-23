require 'spec_helper'

describe Admin::VideosController do
  describe "GET new" do
    it_behaves_like "require sign in" do
      let(:action) { get :new }
    end

    it_behaves_like "require admin" do
      let(:action) { get :new }
    end

    it "sets the @video to a new video" do
      set_current_admin
      get :new
      expect(assigns(:video)).to be_instance_of Video
      expect(assigns(:video)).to be_new_record
    end

    it "sets the flash error message for regular user" do
      set_current_user
      get :new
      expect(flash[:error]).to be_present
    end
  end

  describe "POST create" do
    it_behaves_like "require sign in" do
      let(:action) { post :create }
    end

    it_behaves_like "require admin" do
      let(:action) { post :create }
    end

    context "with valid input" do
      before do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { title: "Monk", category_id: category.id, description: "good show!" }
      end

      it "redirects to the add new video page" do
        expect(response).to redirect_to new_admin_video_path
      end

      it "creates a video" do
        expect(Video.all.count).to eq(1)
      end
      
      it "sets the flash success message" do
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid input" do
      before do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { category_id: category.id, description: "good show!" }
      end

      it "does not create a video" do
        expect(Video.all.count).to eq(0)
      end

      it "render the :new template" do
        expect(response).to render_template :new
      end

      it "sets the @video variable" do
        expect(assigns(:video)).to be_present
      end

      it "sets the flash error message" do
        expect(flash[:error]).to be_present
      end
    end

  end
end