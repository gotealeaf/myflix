require 'rails_helper'

describe InvitedRegistrationsController do
  describe 'GET new' do
    context 'when user is authenticated' do

      before { set_session_user }

      it 'should assign @friend_name' do
        inviter = Fabricate(:user)
        get :new, friend_name: 'Nelle', inviter_id: inviter.id
        expect(assigns(:friend_name)).to eq('Nelle')
      end
      it 'should assign @friend_email' do
        inviter = Fabricate(:user)
        get :new, friend_email: 'nelle@example.com', inviter_id: inviter.id
        expect(assigns(:friend_email)).to eq('nelle@example.com')
      end
      it 'should assign @inviter' do
        inviter = Fabricate(:user)
        get :new, inviter_id: inviter.id
        expect(assigns(:inviter)).to eq(inviter)
      end
      it 'should assign @token' do
        inviter = Fabricate(:user)
        get :new, inviter_id: inviter.id
        expect(assigns(:token)).to eq(inviter.user_tokens.first)
      end

      it 'should render user/new template' do
        inviter = Fabricate(:user)
        get :new, inviter_id: inviter.id
        expect(response).to render_template 'users/new'
      end
    end

    it_behaves_like 'redirect for unauthenticated user' do
      let(:action) { get :new }
    end
  end
end
