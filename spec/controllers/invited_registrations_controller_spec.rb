require 'rails_helper'

describe InvitedRegistrationsController do
  describe 'GET new' do
    before { set_session_user }

    it 'should assign @friend_name' do
      get :new, friend_name: 'Nelle'
      expect(assigns(:friend_name)).to eq('Nelle')
    end
    it 'should assign @friend_email' do
      get :new, friend_email: 'nelle@example.com'
      expect(assigns(:friend_email)).to eq('nelle@example.com')
    end
    it 'should assign @token' do
      get :new, token: 1234
      expect(assigns(:token)).to eq("1234")
    end

    it 'should render user/new template' do
      inviter = Fabricate(:user)
      get :new, token: 1234
      expect(response).to render_template 'users/new'
    end
  end
end
