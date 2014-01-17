require 'spec_helper'

describe UsersController do

  describe 'GET new' do
    it 'sets @user' do
      get :new
      expect(assigns(:user)).to be_instance_of(User) 
    end
  end

  context 'with valid input' do
    before do
      post :create, user: Fabricate.attributes_for(:user) 
    end
    it 'creates the user' do
      expect(User.count).to eq(1)
    end
    it 'redirects user to the sign in page' do
      expect(response).to redirect_to sign_in_path
    end
  end

  context 'with invalid input' do
    before do
      post :create, user: { email: 'bob@example.com' }
    end
    it 'does not creates the user' do
      expect(User.count).to eq(0)
    end
    it 'renders the new template' do
      expect(response).to render_template :new
    end
    it 'sets @user' do
      expect(assigns(:user)).to be_instance_of(User) 
    end
  end

end
