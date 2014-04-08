require 'spec_helper'

describe Admin::VideosController do
  describe 'GET new' do
    context "with authenticatied users" do
      it "should set @video to a new video" do
        admin = Fabricate(:admin)
        set_current_user(admin)
        get :new
        expect(assigns(:video)).to be_instance_of Video
        expect(assigns(:video)).to be_new_record
      end
    end

    context "with unauthenticatied users" do
      it_behaves_like "requires sign in" do
        let(:action) { get :new }
      end

      it_behaves_like "requires admin" do
        let(:action) { get :new }
      end
    end
  end

  describe 'POST create' do
    context 'with authenticatied users' do
      context 'with valid input' do
        it "should redirect to new video page" do
          admin = Fabricate(:admin)
          set_current_user(admin)
          category = Fabricate(:category)
          post :create, video: { title: 'video1', category_id: category.id, description: 'Video1 description' }
          expect(response).to redirect_to new_admin_video_path
        end
        it "should create a new video" do
          admin = Fabricate(:admin)
          set_current_user(admin)
          category = Fabricate(:category)
          post :create, video: { title: 'video1', category_id: category.id, description: 'Video1 description' }
          expect(Video.count).to eq(1)
        end
        it "should set success message" do
          admin = Fabricate(:admin)
          set_current_user(admin)
          category = Fabricate(:category)
          post :create, video: { title: 'video1', category_id: category.id, description: 'Video1 description' }
          expect(flash[:info]).to be_present
        end
      end

      context 'with invalid input' do
        it "should render the new template" do
          admin = Fabricate(:admin)
          set_current_user(admin)
          category = Fabricate(:category)
          post :create, video: { category_id: category.id, description: 'Video1 description' }
          expect(response).to render_template :new
        end
        it "should not create a new video" do
          admin = Fabricate(:admin)
          set_current_user(admin)
          category = Fabricate(:category)
          post :create, video: { category_id: category.id, description: 'Video1 description' }
          expect(Video.count).to eq(0)
        end
        it "should set @video variable" do
          admin = Fabricate(:admin)
          set_current_user(admin)
          category = Fabricate(:category)
          post :create, video: { category_id: category.id, description: 'Video1 description' }
          expect(assigns(:video)).to be_present
        end
        it "should set error message" do
          admin = Fabricate(:admin)
          set_current_user(admin)
          category = Fabricate(:category)
          post :create, video: { category_id: category.id, description: 'Video1 description' }
          expect(flash[:danger]).to be_present
        end
      end
    end

    context "with unauthenticatied users" do
      it_behaves_like "requires sign in" do
        let(:action) { get :new }
      end

      it_behaves_like "requires admin" do
        let(:action) { get :new }
      end
    end
  end
end
