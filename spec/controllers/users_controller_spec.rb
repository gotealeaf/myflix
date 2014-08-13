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
    context 'if validation passes' do
      it 'creates a new user' do
        post :create, user: Fabricate.attributes_for(:user), stripeToken: stripe_token.id
        expect(User.all.count).to eq(1)
      end
      it 'delivers a welcome email' do
        post :create, user: Fabricate.attributes_for(:user), stripeToken: stripe_token.id
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end
      it 'delivers to the correct recipient' do
        post :create, user: { username:'test_user', full_name: 'test_user',
                              email: 'user@example.com', password: 'password',
                              password_confirmation: 'password' }, stripeToken: stripe_token.id
        expect(ActionMailer::Base.deliveries.last.to).to eq(['user@example.com'])
      end
      it 'has the correct content' do
        post :create, user: { username:'test_user', full_name: 'test_user',
                              email: 'user@example.com', password: 'password',
                              password_confirmation: 'password' }, stripeToken: stripe_token.id
        expect(ActionMailer::Base.deliveries.last.body).to include('Welcome to MyFlix')
      end
      it 'Flash a welcome message' do
        post :create, user: Fabricate.attributes_for(:user), stripeToken: stripe_token.id
        expect(flash[:success].blank?).to eq(false)
      end
      it 'assigns session[:user]' do
        post :create, user: Fabricate.attributes_for(:user), stripeToken: stripe_token.id
        expect(session[:username].blank?).to eq(false)
      end
      it 'redirects to video_path' do
        post :create, user: Fabricate.attributes_for(:user), stripeToken: stripe_token.id
        expect(response).to redirect_to videos_path
      end
      context 'if user was invited to register' do
        it 'should delete the token after registration' do
          user_token = Fabricate(:user_token)
          post :create, user: Fabricate.attributes_for(:user), token: user_token.token, stripeToken: stripe_token.id
          expect(UserToken.count).to eq(0)
        end
        it 'should create a new following for new user to inviter if invited' do
          inviter = Fabricate(:user)
          user_token = Fabricate(:user_token, user: inviter)
          post :create, user: Fabricate.attributes_for(:user), token: user_token.token, stripeToken: stripe_token.id
          new_user = User.where.not(id: inviter.id).first
          expect(new_user.followings.first.followee).to eq(inviter)
        end
        it 'should create a new following for inviter to new user if invited' do
          inviter = Fabricate(:user)
          user_token = Fabricate(:user_token, user: inviter)
          post :create, user: Fabricate.attributes_for(:user), token: user_token.token, stripeToken: stripe_token.id
          new_user = User.where.not(id: inviter.id).first
          expect(inviter.followings.first.followee).to eq(new_user)
        end
      end
    end

    context 'if validation fails' do
      let(:action) { post :create, user: { username: 'test_user' } }

      it 'does not create a user' do
        action
        expect(User.count).to eq(0)
      end

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

  describe 'GET invited' do

  end
end
