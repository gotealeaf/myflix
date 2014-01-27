require 'spec_helper'

describe UsersController do

  describe 'GET #new' do
    it 'should set up @user variable' do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe 'POST #create' do
    context 'with valid input' do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it 'creates the user' do
        expect(User.count).to eq(1)
      end

      it 'logs user in' do
        expect(session[:user_id]).to eq(User.first.id)
      end

      it 'shows success message' do
        expect(flash[:success]).not_to be_blank
      end

      it 'redirects to home path' do
        expect(response).to redirect_to home_path
      end
    end

    context 'with invalid input' do
      before { post :create, user: { email: 'user@example.com', full_name: 'Joe Smith' } }

      it 'does not create the user' do
        expect(User.count).to eq(0)
      end

      it 'renders new template' do
        expect(response).to render_template :new
      end

      it 'sets @user' do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end
