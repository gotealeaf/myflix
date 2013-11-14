require 'spec_helper'

describe UsersController do
  describe 'GET new' do
    it 'sets the @user variable' do
      get :new
      expect(assigns(:user)).to be_new_record
      expect(assigns(:user)).to be_instance_of(User)
    end
    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST create' do
    context 'with valid input' do
      before do
        post :create, user: Fabricate.attributes_for(:user) 
      end

      it 'creates the @user variable' do
        expect(User.count).to eq(1)
      end
      it 'sets the success message' do
        expect(flash[:success]).not_to be_blank
      end
      it 'sets the session[:user_id]' do
        expect(session[:user_id]).to eq(User.first.id)
      end
      it 'redirects to the home_path' do
        expect(response).to redirect_to home_path
      end
    end

    context 'with invalid input' do 
      before do
        post :create, user: { password: 'password', full_name: 'Gina Zhou' }
      end

      it 'does not create @user' do
        expect(User.count).to eq(0)
      end
      it 'renders the new template' do
        expect(response).to render_template :new
      end
      it 'sets the @user variable' do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end