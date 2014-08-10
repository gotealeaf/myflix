require 'rails_helper'

describe Admin::VideosController do
  describe 'GET new' do
    context 'when user is authenticated' do

      it_behaves_like 'requires admin' do
        let(:action) { get :new }
      end

      it 'assigns @video when user is admin' do
        set_session_user
        user.update(admin: true)
        get :new
        expect(assigns(:video)).to be_instance_of(Video)
        expect(assigns(:video)).to be_new_record
      end
    end

    it_behaves_like 'redirect for unauthenticated user' do
      let(:action) { get :new }
    end
  end

  describe 'POST create' do
    it_behaves_like 'redirect for unauthenticated user' do
      let(:action) { get :create }
    end

    it_behaves_like 'requires admin' do
      let(:action) { get :create }
    end

    context 'with valid inputs' do
      before { set_session_admin }
      it 'creates a video' do
        genre = Fabricate(:genre)
        post :create, video: Fabricate.attributes_for(:video, genre: genre)
        expect(Video.count).to eq(1)
      end
      it 'creates a video associated to a genre' do
        genre = Fabricate(:genre)
        post :create, video: Fabricate.attributes_for(:video, genre: genre)
        expect(Video.first.genre).to eq(genre)
      end
      it 'redirects to new video page' do
        genre = Fabricate(:genre)
        post :create, video: Fabricate.attributes_for(:video, genre: genre)
        expect(response).to redirect_to new_admin_video_path
      end
      it 'flash success message' do
        genre = Fabricate(:genre)
        post :create, video: Fabricate.attributes_for(:video, genre: genre)
        expect(flash[:notice]).to include('has been added successfully!')
      end
    end
    context 'with invalid inputs' do
      before { set_session_admin }
      it 'does not create a new video' do
        genre = Fabricate(:genre)
        post :create, video: Fabricate.attributes_for(:video, genre_id: "")
        expect(Video.count).to eq(0)
      end
      it 'renders new template' do
        genre = Fabricate(:genre)
        post :create, video: Fabricate.attributes_for(:video, genre_id: "")
        expect(response).to render_template :new
      end
      it 'sets video variable' do
        genre = Fabricate(:genre)
        post :create, video: Fabricate.attributes_for(:video, genre_id: "")
        expect(assigns(:video)).to be_instance_of(Video)
        expect(assigns(:video)).to be_new_record
      end
      it 'flash error message' do
        genre = Fabricate(:genre)
        post :create, video: Fabricate.attributes_for(:video, genre_id: "")
        expect(flash[:danger]).to eq('Video could not be uploaded, please check errors.')
      end
    end
  end
end
