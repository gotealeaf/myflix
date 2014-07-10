require 'spec_helper'

describe Admin::VideosController do
  describe 'GET new' do

    it_behaves_like "require_sign_in" do
      let(:action) { get :new }
    end 

    it 'sets @video variable to a neew video' do
      set_current_admin
      get :new

      expect(assigns :video).to be_instance_of Video
      expect(assigns :video).to be_new_record
    end

    it_behaves_like "require_admin" do
      let(:action) { post :new }
    end

    it "sets the flash error message for regular user" do
      set_current_user
      get :new

      expect(flash[:error]).to be_present
    end
  end

  describe 'POST create' do
    it_behaves_like "require_sign_in" do
      let(:action) { post :create }
    end

    it_behaves_like "require_admin" do
      let(:action) { post :create }
    end

    context "with valid input" do
      it "redirects to the add new video page" do
        set_current_admin
        category = Fabricate :category
        post :create, video: { title: "Curro Jiménez", category_id: category.id, description: "Grandisísima serie." }   

        expect(response).to redirect_to new_admin_video_path
      end

      it "creates a video" do
        set_current_admin
        category = Fabricate :category
        post :create, video: { title: "Curro Jiménez", category_id: category.id, description: "Grandisísima serie." }

        expect(category.videos.count).to eq(1)
      end


      it "sets flash success message" do
        set_current_admin
        category = Fabricate :category
        post :create, video: { title: "Curro Jiménez", category_id: category.id, description: "Grandisísima serie." }

        expect(flash[:success]).to be_present
      end
    end

    context "with invalid input" do
      it "does not create a video" do
        set_current_admin
        category = Fabricate :category
        post :create, video: { category_id: category.id, description: "Grandisísima serie." }

        expect(category.videos.count).to eq(0)
      end

      it "renders the new template" do
        set_current_admin
        category = Fabricate :category
        post :create, video: { category_id: category.id, description: "Grandisísima serie." }

        expect(response).to render_template :new
      end

      it "sets @video variable" do
        set_current_admin
        category = Fabricate :category
        post :create, video: { category_id: category.id, description: "Grandisísima serie." }

        expect(assigns :video).to be_instance_of Video
        expect(assigns :video).to be_new_record
      end

      it "sets flash error message" do
        set_current_admin
        category = Fabricate :category
        post :create, video: { category_id: category.id, description: "Grandisísima serie." }

        expect(flash[:error]).to be_present
      end
    end
  end
end