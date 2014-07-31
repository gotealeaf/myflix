require 'rails_helper'

describe InvitedRegistrationsController do
  describe 'GET new' do

    before { set_session_user }

    context 'when token is valid' do
      let(:user_token) {  Fabricate(:user_token) }
      it 'should assign @friend_name' do
        get :new, friend_name: 'Nelle', token: user_token.token
        expect(assigns(:friend_name)).to eq('Nelle')
      end
      it 'should assign @friend_email' do
        get :new, friend_email: 'nelle@example.com',token: user_token.token
        expect(assigns(:friend_email)).to eq('nelle@example.com')
      end
      it 'should assign @token' do
        get :new, token: user_token.token
        expect(assigns(:token)).to eq(user_token.token)
      end
      it 'should render user/new template' do
        inviter = Fabricate(:user)
        get :new, token: user_token.token
        expect(response).to render_template 'users/new'
      end
    end

    context 'when token has expired' do
      it 'redirects to registration page' do
        get :new, token: 1234
        expect(response).to redirect_to register_path
      end
    end
  end
end
