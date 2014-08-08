require 'rails_helper'

describe Admin::VideosController do
  describe 'GET new' do
    context 'when user is authenticated' do
      it 'redirects to home page if user is not admin' do
        set_session_user
        get :new
        expect(response).to redirect_to home_path
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
end
