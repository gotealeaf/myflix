require 'spec_helper'

describe VideosController do
  context "authenticated user" do
    let(:cat){ Fabricate(:category) }
    before { session[:user_id] = Fabricate(:user).id }

    describe "GET index" do
      before { get :index }

      it "assigns @categories" do
        expect(assigns(:categories)).to eq([cat])
      end

      it "renders template :index" do
        expect(response).to render_template :index
      end
    end

    describe "GET show" do
      let(:video) {Fabricate(:video)}
      let(:review1) { Fabricate(:review, video: video) }
      let(:review2) { Fabricate(:review, video: video) }
      before { get :show, id: video.id }

      it "assigns @video" do
        expect(assigns(:video)).to eq(video)
      end

      it "assigns @reviews" do
        expect(assigns(:reviews)).to match_array([review1, review2])
      end

      it "assigns @review" do
        expect(assigns(:review)).to be_new_record
      end

      it "renders template :show" do
        expect(response).to render_template :show
      end
    end


    describe "GET search" do
      let(:strain) { Fabricate(:video, title:"strain") }
      before { 100.times { Fabricate(:video) } }

      context "match input" do
        before { get :search, search: "strain" }

        it "assigns @videos" do
          expect(assigns(:videos)).to include(strain)
        end

        it "renders template :search" do
          expect(response). to render_template :search
        end
      end

      context "unmatch input" do
        before { get :search, search: "safd" }

        it "assigns @videos as empty" do
          expect(assigns(:videos)).to eq([])
        end

        it "renders template :search" do
          expect(response). to render_template :search
        end
      end
    end


    describe "GET new" do
      before { get :new }

      it "assigns @video" do
        expect(assigns(:video)).to be_new_record
        expect(assigns(:video)).to be_instance_of(Video)
      end

      it "renders template :new" do
        expect(response).to render_template :new
      end
    end

    describe "POST create" do
      context "when input is valid" do
        it "creates a video record" do
          expect{
            post :create, video: Fabricate.attributes_for(:video)
          }.to change(Video, :count).by(1)
        end

        it "redirect to root_path" do
          post :create, video: Fabricate.attributes_for(:video)
          expect(response).to redirect_to root_path
        end
      end

      context "when input is invalid" do
        it 'do not create a video record' do
          expect{
            post :create, video: Fabricate.attributes_for(:video, category_id: nil)
          }.not_to change(Video, :count)
        end

        it 'renders a template :new' do
          post :create, video: Fabricate.attributes_for(:video, category_id: nil)
          expect(response).to render_template :new
        end
      end
    end
  end

  context "unauthenticated user" do
    let(:video) { Fabricate(:video) }

    describe "GET index" do
      it "redirect to signin_path" do
        get :index
        expect(response).to redirect_to signin_path
      end
    end

    describe "GET show" do
      it "redirect to signin_path" do
        get :show, id: video
        expect(response).to redirect_to signin_path
      end
    end

    describe "GET search" do
      it "redirect to signin_path" do
        get :search, search: "monk"
        expect(response).to redirect_to signin_path
      end
    end

    describe "GET new" do
      it "redirect to signin_path" do
        get :new
        expect(response).to redirect_to signin_path
      end
    end

    describe "POST create" do
      it "redirect to signin_path" do
        post :create, video: Fabricate.attributes_for(:video)
        expect(response).to redirect_to signin_path
      end
    end
  end
end
