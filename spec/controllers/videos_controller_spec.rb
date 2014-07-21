require 'spec_helper'

describe VideosController do

  let(:action ){ FactoryGirl.create(:category) }

  describe "GET index" do
    it "assigns @categories" do

      get :index
      expect(assigns(:categories)).to eq([action])
    end

    it "renders template :index" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET show" do
    let(:monk) {FactoryGirl.create(:video)}
    it "assgins @video" do
      get :show, id: monk.id
      expect(assigns(:video)).to eq(monk)
    end

    it "render template :show" do
      get :show, id: monk.id
      expect(response).to render_template :show
    end
  end

  describe "GET new" do
    it "assgins @video" do
      get :new
      expect(assigns(:video)).to be_new_record
      expect(assigns(:video)).to be_instance_of(Video)
    end

    it "render template :new" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    context "when input is valid" do

      it "create a video record" do
        expect{
          post :create, video: FactoryGirl.attributes_for(:video)
        }.to change(Video, :count).by(1)
      end
      it "redirect to root path" do
        post :create, video: FactoryGirl.attributes_for(:video)
        expect(response).to redirect_to root_path
      end
    end
    context "when input is invalid" do
      it 'do not create a video record' do
        expect{
          post :create, video: FactoryGirl.attributes_for(:invalid_video)
        }.not_to change(Video, :count)
      end
      it 'render a template :new' do
        post :create, video: FactoryGirl.attributes_for(:invalid_video)
        expect(response).to render_template :new
      end
    end
  end

end
