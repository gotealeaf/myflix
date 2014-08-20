require "spec_helper"

describe Admin::VideosController do
  describe "GET new" do
    before { set_current_admin }

    it "assigns the @video variable" do
      get :new
      expect(assigns(:video)).to be_a_new(Video)
    end

    it_behaves_like "requires admin" do
      let(:action) { get :new }
    end

    it_behaves_like "require_login" do
      let(:action) { get :new }
    end
  end

  describe "POST create" do
    before { set_current_admin }
     
    context "with valid input" do
      before { post :create, video: Fabricate.attributes_for(:video) }
      
      it "redirects to new video path" do
        expect(response).to redirect_to new_admin_video_path
      end

      it "creates a new video" do
        expect(Video.count).to eq(1) 
      end 

      it "sets the success notice" do
        expect(flash[:notice]).to_not be_empty
      end
    end

    context "with invalid input" do
      before { post :create, video: { title: "Mary Poppins" } }

      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "sets the error notice" do
        expect(flash[:error]).to_not be_empty
      end
    end

    it_behaves_like "requires admin" do
      let(:action) { post :create, video: Fabricate.attributes_for(:video) }
    end
  end
end