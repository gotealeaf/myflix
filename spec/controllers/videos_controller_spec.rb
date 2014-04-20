require 'spec_helper'


describe VideosController do
  describe "GET index" do
    context "with authenticated users" do
      before { set_current_user }
      
      it "sets the @categories variable" do
        cat1 = Category.create(name: "80's")
        cat2 = Category.create(name: "90's")

        get :index

        assigns(:categories).should == [cat1, cat2]
      end

      it "renders the index template" do
        get :index
        response.should render_template :index
      end
    end

    context "unauthenticated users" do
      it_behaves_like "require_sign_in" do
        let(:action) { get :index }
      end
    end
  end

  describe "GET show" do
    context "with authenticated users" do
        before { set_current_user }

        it "sets @video" do
        video = Fabricate :video
        get :show, id: video.id

        expect(assigns :video).to eq video
      end

      it "sets @reviews" do
        video = Fabricate :video
        review1 = Fabricate(:review, video: video)
        review2 = Fabricate(:review, video: video)

        get :show, id: video.id

        expect(assigns :reviews).to match_array ([review1, review2])
      end

      it "renders the show template" do
        video = Fabricate :video
        get :show, id: video.id

        response.should render_template :show
      end
    end

    context "unauthenticated users" do
      it_behaves_like "require_sign_in" do
        video = Fabricate :video
        let(:action) { get :show, id: video.id }
      end
    end
  end

  describe "POST search" do
    it "sets the @video with authenticated users" do
      set_current_user
      video = Fabricate :video, title: "Paquito"

      post :search, title: "Paquito"

      expect(assigns :videos).to eq([video])
    end

    it_behaves_like "require_sign_in" do
      let(:action) { post :search, title: "Paq" }
    end
  end 
end
