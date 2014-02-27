require 'spec_helper'

describe UsersController do
  describe 'GET new' do
    it "creates a new User object" do
      get :new
      expect(assigns(:user)).to be_new_record
      expect(assigns(:user)).to be_instance_of(User)
    end
    it "should render the Register page" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET new_with_token' do
    it "should render the Register page" do
      user = Fabricate(:user)
      friend = Fabricate(:friend, user: user)
      get :new_with_token, token: friend.token
      expect(response).to render_template :new
    end
    it "should populate the form's fields with the user name and email address" do
      user = Fabricate(:user)
      friend = Fabricate(:friend, user: user)
      get :new_with_token, token: friend.token
      expect(assigns(:user).email).to eq(friend.email)
      expect(assigns(:user).full_name).to eq(friend.full_name)
    end
    it "should set the @token instance variable" do
      user = Fabricate(:user)
      friend = Fabricate(:friend, user: user)
      get :new_with_token, token: friend.token
      expect(assigns(:token)).to eq(friend.token)
    end
    it "should redirect the user to the Expired Token page if the token is invalid" do
      user = Fabricate(:user)
      friend = Fabricate(:friend, user: user)
      get :new_with_token, token: "12345"
      expect(response).to redirect_to expired_token_path
    end
  end

  describe 'GET show' do
    it "should have a user object" do
      set_current_user
      user = Fabricate(:user)
      get :show, id: user.token
      expect(assigns(:user)).to eq(user)
    end
    it_behaves_like "require sign in" do
      let(:action) { get :show, id: 1 }
    end
  end

  describe 'POST create' do
    context "with valid input and valid card" do
      before do
        charge = double(:charge, successful?: true)
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
      end
      it "creates a new user" do
        create_user_valid_credentials
        expect(User.count).to eq(1)
      end
      it "redirects to the root" do
        create_user_valid_credentials
        expect(response).to redirect_to root_path
      end
      it "creates a new session" do
        post :create, user: {email: 'jlevinger@jtonedesigns.com', password: 'joelevinger', full_name: 'Joe Levinger'}
        expect(session[:user_id]).not_to eq nil
      end
      it "should make sure that the new user follows the person who invited him if a token is present" do
        joe = Fabricate(:user)
        friend = Fabricate(:friend, full_name: "Alice Humperdink", user: joe)
        post :create, user: {email: friend.email, full_name: friend.full_name, password: "alice"}, token: friend.token
        expect(User.last.following?(joe)).to eq(true)
      end
      it "should make sure that the person who invited the new user follows him if a token is present" do
        joe = Fabricate(:user)
        friend = Fabricate(:friend, full_name: "Alice Humperdink", user: joe)
        post :create, user: {email: friend.email, full_name: friend.full_name, password: "alice"}, token: friend.token
        expect(joe.following?(User.last)).to eq(true)
      end
      it "expires the invitation upon acceptance" do
        joe = Fabricate(:user)
        friend = Fabricate(:friend, full_name: "Alice Humperdink", user: joe)
        post :create, user: {email: friend.email, full_name: friend.full_name, password: "alice"}, token: friend.token
        expect(friend.reload.token).to eq(nil)
      end
    end
    context "with valid input and declined card" do
      it "renders the new template" do
        charge = double(:charge, successful?: false, error_message: "Your card was declined.")
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
        post :create, user: {email: "alice@example.com", full_name: "Alice Jones", password: "alice"}, stripeToken: "12345"
        expect(response).to render_template :new
      end
      it "it does not create a user record" do
        charge = double(:charge, successful?: false, error_message: "Your card was declined.")
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
        post :create, user: {email: "alice@example.com", full_name: "Alice Jones", password: "alice"}, stripeToken: "12345"
        expect(User.count).to eq(0)
      end
      it "sets a flash error message" do
        charge = double(:charge, successful?: false, error_message: "Your card was declined.")
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
        post :create, user: {email: "alice@example.com", full_name: "Alice Jones", password: "alice"}, stripeToken: "12345"
        expect(flash[:error]).to be_present
      end
    end
    context "with invalid input" do
      before { create_user_invalid_credentials }
      it "does not create a new user" do
        expect(User.count).to eq(0)
      end
      it "renders the new template again" do
        expect(response).to render_template :new
      end
      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
      it "does not charge the card" do
        StripeWrapper::Charge.should_not_receive(:create)
        create_user_invalid_credentials
      end
      it "does not send an email if the user record is invalid" do
        ActionMailer::Base.deliveries.clear
        post :create, user: {email: 'alice@example.com', password: 'alice', full_name: ''}
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end
    end
    context "email sending" do
      before do
        charge = double(:charge, successful?: true)
        StripeWrapper::Charge.should_receive(:create).and_return(charge)
        ActionMailer::Base.deliveries.clear
      end
      it "sends out the email" do
        post :create, user: {email: 'alice@example.com', password: 'alice', full_name: 'Alice Humperdink'}
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end
      it "sends to the right recipient" do
        post :create, user: {email: 'alice@example.com', password: 'alice', full_name: 'Alice Humperdink'}
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq(['alice@example.com'])
      end
      it "has the right content" do
        post :create, user: {email: 'alice@example.com', password: 'alice', full_name: 'Alice Humperdink'}
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to include('Alice Humperdink')
      end
    end
  end

  private

  def create_user_valid_credentials
    post :create, user: Fabricate.attributes_for(:user)
  end

  def create_user_invalid_credentials
    post :create, user: { password: 'joelevinger', full_name: 'Joe Levinger' }
  end
end