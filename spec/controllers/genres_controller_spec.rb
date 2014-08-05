require 'rails_helper'

describe GenresController do
  describe 'Get #show' do
    it_behaves_like 'redirect for unauthenticated user' do
      let(:action) { get :show, id: 1}
    end
    it 'assigns @genre when user is authenticated' do
      set_session_user
      genre = Fabricate(:genre, name: 'action')
      video = Fabricate(:video, genre: genre)
      get :show, id: genre.id
      expect(assigns(:genre)).to eq(genre)
    end
  end

  describe 'POST #create' do
    it_behaves_like 'redirect for unauthenticated user' do
      let(:action) { get :show, id: 1}
    end
    context 'with valid inputs' do
      before { set_session_user }
      it 'assigns @genre when user is authenticated' do
        post :create, genre: {name: 'action'}
        expect(assigns(:genre).name).to eq('action')
      end
      it 'creates a new genre when saved' do
        post :create, genre: {name: 'action'}
        expect(Genre.count).to eq(1)
      end
      it 'redirects to home page' do
        post :create, genre: {name: 'action'}
        expect(response).to redirect_to root_path
      end
    end
    context 'with invalid inputs' do
      it 'renders genre/new' do
        set_session_user
        post :create, genre: {name: ''}
        expect(response).to render_template(:new)
      end
    end
  end

end
