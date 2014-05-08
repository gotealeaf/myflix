require 'spec_helper'
  
describe Admin::VideosController do
  describe "GET new" do
    it_behaves_like "requires login" do
      let(:action) { get :new }
    end

    it_behaves_like "requires admin" do
      let(:action) { get :new }      
    end

    it "sets @video if user is admin" do
      set_current_admin
      get :new
      expect(assigns(:video)).to be_instance_of(Video)
      expect(assigns(:video)).to be_new_record
    end
  end

  describe "POST create" do
    it_behaves_like "requires login" do
      let(:action) { post :create }      
    end

    it_behaves_like "requires admin" do
      let(:action) { post :create }      
    end

    context "input is valid" do
      it "saves the video" do
        set_current_admin
        post :create, video: Fabricate.attributes_for(:video)
        expect(assigns(:video)).to be_instance_of(Video)
        expect(assigns(:video).save).to be_true
      end

      it "sets a flash success message" do
        set_current_admin
        post :create, video: Fabricate.attributes_for(:video)
        expect(flash[:success]).to eq("The video #{Video.first.title} has been saved!")
      end

      it "redirects to the new video page" do
        set_current_admin
        post :create, video: Fabricate.attributes_for(:video)
        expect(response).to redirect_to new_admin_video_path
      end
    end

    context "input is not valid" do
      it "does not save the video" do
        set_current_admin
        post :create, video: Fabricate.attributes_for(:bad_video)
        expect(assigns(:video).save).to be_false
      end

      it "sets a flash danger message" do
        set_current_admin
        post :create, video: Fabricate.attributes_for(:bad_video)
        expect(flash[:danger]).to eq("The video could not be saved, due to the following errors:")
      end

      it "sets the @video variable" do
        set_current_admin
        post :create, video: Fabricate.attributes_for(:bad_video)
        expect(assigns(:video)).to be_instance_of(Video)
      end

      it "renders the new video template" do
        set_current_admin
        post :create, video: Fabricate.attributes_for(:bad_video)
        expect(response).to render_template :new
      end
    end
  end
end