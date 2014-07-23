require 'spec_helper'

describe VideosController do

  context "with autheticated user" do
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
      before { get :show, id: video.id }

      it "assgins @video" do
        expect(assigns(:video)).to eq(video)
      end
      it "render template :show" do
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
        it "render template :search" do
          expect(response). to render_template :search
        end
      end

      context "unmatch input" do
        before { get :search, search: "safd" }

        it "assigns @videos as empty" do
          expect(assigns(:videos)).to eq([])
        end
        it "render template :search" do
          expect(response). to render_template :search
        end
      end
    end


    describe "GET new" do
      before { get :new }

      it "assgins @video" do
        expect(assigns(:video)).to be_new_record
        expect(assigns(:video)).to be_instance_of(Video)
      end
      it "render template :new" do
        expect(response).to render_template :new
      end
    end

    describe "POST create" do

      context "when input is valid" do
        it "create a video record" do
          expect{
            post :create, video: Fabricate.attributes_for(:video)
          }.to change(Video, :count).by(1)
        end
        it "redirect to root path" do
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
        it 'render a template :new' do
          post :create, video: Fabricate.attributes_for(:video, category_id: nil)
          expect(response).to render_template :new
        end
      end
    end
  end

  context "without autheticated user" do
    
  end
end
