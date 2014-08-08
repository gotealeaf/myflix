require 'spec_helper'

describe VideosController do

  let(:current_user) { Fabricate(:user) }
  before { session[:user_id] = current_user.id }

  describe "GET index" do
    let(:cat) { Fabricate(:category) }
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
    before { get :show, id: video.token }

    it "assigns @video" do
      expect(assigns(:video)).to eq(video)
    end

    it "assigns @reviews" do
      expect(assigns(:reviews)).to match_array([review1, review2])
    end

    it "renders template :show" do
      expect(response).to render_template :show
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: video.id }
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

    it_behaves_like "requires sign in" do
      let(:action) { get :new }
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
          post :create, video: Fabricate.attributes_for(:video, category: nil)
        }.not_to change(Video, :count)
      end

      it 'renders a template :new' do
        post :create, video: Fabricate.attributes_for(:video, category: nil)
        expect(response).to render_template :new
      end
    end


    it_behaves_like "requires sign in" do
      let(:action) { get :create }
    end
  end

end
