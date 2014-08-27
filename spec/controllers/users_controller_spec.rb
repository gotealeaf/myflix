require 'rails_helper'

describe UsersController do
  describe 'GET new' do
    it 'creates a new @user object' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
    it_behaves_like 'new User object' do
      let(:action) { get :new }
    end
    # no need to test render new because it's a rails code
  end

  describe 'POST create' do
    context 'if validation passes for personal info and credit card' do

      let(:user_signup) { double('user_signup', successful?: true) }

      before do
        allow_any_instance_of(UserSignup).to receive(:sign_up) { user_signup }
      end

      it 'Flash a welcome message' do
        post :create, user: Fabricate.attributes_for(:user)
        expect(flash[:success].blank?).to eq(false)
      end
      it 'assigns session[:user]' do
        post :create, user: Fabricate.attributes_for(:user)
        expect(session[:username].blank?).to eq(false)
      end
      it 'redirects to video_path' do
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to videos_path
      end

    end
    context 'if personal info valid but credit card invalid' do

      let(:user_signup) { double('user_signup', successful?: false, error_message: 'Your card was declined') }

      before do
        allow_any_instance_of(UserSignup).to receive(:sign_up) { user_signup }
      end

      it 'renders the new template' do
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '12345'
        expect(response).to render_template(:new)
      end
      it 'flashes an error message' do
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '12345'
        expect(flash[:danger]).to eq("Your card was declined")
      end
    end

    context 'if validation fails' do

      let(:action) { post :create, user: { username: 'test_user' } }

      it 'renders new template' do
        action
        expect(response).to render_template(:new)
      end
      it 'creates a new @user object' do
        action
        expect(assigns(:user)).to be_a_new(User)
      end
      it_behaves_like 'new User object'
    end
  end

  describe 'GET show' do
    context 'when user is authenticated' do
      it 'assigns the @user variable' do
        set_session_user
        get :show, id: user.id
        expect(assigns(:user)).to eq (user)
      end
    end
    it_behaves_like 'redirect for unauthenticated user' do
      let(:action) { get :show, id: 1}
    end
  end
end
