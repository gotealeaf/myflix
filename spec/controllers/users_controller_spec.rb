require 'spec_helper'

describe UsersController do
  before do
    ActionMailer::Base.deliveries.clear
  end

  describe 'GET #new' do
    it 'should set up @user variable' do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe 'POST #create' do
    context 'with valid input' do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

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

      it 'sends welcome email' do
        expect(ActionMailer::Base.deliveries).not_to be_empty
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

      it 'does not send welcome email' do
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end

  describe 'GET #show' do
    before { set_current_user }
    it_behaves_like 'an unauthenticated user' do
      let(:action) { get :show, id: 1 }
    end

    it 'sets the @user variable based on the provided id' do
      adam = Fabricate(:user)
      get :show, id: adam.id
      expect(assigns(:user)).to eq(adam)
    end
  end

  describe 'POST #forgot_password' do
    it 'redirects to confirm_password_reset_path if an email address was provided' do
      adam = Fabricate(:user)
      post :forgot_password, email_address: adam.email
      expect(response).to redirect_to(confirm_password_reset_path)
    end

    it 'renders the form again if no email was provided' do
      post :forgot_password, email_address: ''
      expect(response).to render_template(:forgot_password)
    end

    it 'creates a reset token' do
      adam = Fabricate(:user)
      expect(adam.password_reset_token).to be_nil
      post :forgot_password, email_address: adam.email
      expect(adam.reload.password_reset_token).not_to be_nil
    end

    it 'sends a password reset email' do
      adam = Fabricate(:user)
      expect(adam.password_reset_token).to be_nil
      post :forgot_password, email_address: adam.email
      expect(ActionMailer::Base.deliveries).not_to be_empty
    end
  end

  describe 'POST #reset_password' do
    it 'redirects to sign in page' do
      adam = Fabricate(:user)
      adam.generate_password_reset_token
      post :reset_password, token: adam.password_reset_token, password: 'password'
      expect(response).to redirect_to(sign_in_path)
    end

    it 'sets a success message if the password is changed successfully' do
      adam = Fabricate(:user)
      adam.generate_password_reset_token
      post :reset_password, token: adam.password_reset_token, password: 'password'
      expect(flash[:success]).not_to be_blank
    end

    it 'sets a failure message if the password if not changed successfully' do
      adam = Fabricate(:user)
      adam.generate_password_reset_token
      post :reset_password, token: adam.password_reset_token, password: ''
      expect(flash[:danger]).not_to be_blank
    end

    it 'resets the users password to the given password' do
      adam = Fabricate(:user)
      adam.generate_password_reset_token
      post :reset_password, token: adam.password_reset_token, password: 'password'
      expect(adam.reload.authenticate('password')).to be_instance_of(User)
    end

    it 'expires users password reset token' do
      adam = Fabricate(:user)
      adam.generate_password_reset_token
      post :reset_password, token: adam.password_reset_token, password: 'password'
      expect(adam.reload.password_reset_token).to be_nil
    end
  end
end
