require 'rails_helper'

describe InvitedRegistrationsController do
  describe 'GET new' do
    it 'should assign @friend_name' do
      get :new, friend_name: 'Nelle'
      expect(assigns(:friend_name)).to eq('Nelle')
    end
    it 'should assign @friend_email' do
      get :new, friend_email: 'nelle@example.com'
      expect(assigns(:friend_email)).to eq('nelle@example.com')
    end
    it 'should assign @user_id' do
      get :new, inviter_id: 1
      expect(assigns(:inviter_id)).to eq("1")
    end
    it 'should render user/new template' do
      get :new
      expect(response).to render_template 'users/new'
    end
  end
end
