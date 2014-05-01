require 'spec_helper'

describe UsersController do
  describe "GET new" do
    let(:action) { get :new }

    it "sets warning if authenticated" do
      set_current_user
      action
      expect(flash[:warning]).to eq "You are already logged in."
    end

    it "redirects to home path if authenticated" do
      set_current_user
      action
      expect(response).to redirect_to home_path
    end

    it "sets @user to a new user if unauthenticated" do
      action
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe "POST create" do
    context "with valid input" do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it "creates the user" do
        expect(User.count).to eq 1
      end

      it "redirects to sign in" do
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with invalid input" do
      before { post :create, user: Fabricate.attributes_for(:user, password: nil) }

      it "does not create the user" do
        expect(User.count).to eq 0
      end

      it "renders the new user template" do
        expect(response).to render_template :new
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of User
      end
    end

    context "registration email" do
      after { ActionMailer::Base.deliveries = [] }

      it "sends the email with valid input" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end

      it "sends the email to the user's email address with valid input" do
        post :create, user: Fabricate.attributes_for(:user, email: 'bill@exmpl.com')
        expect(ActionMailer::Base.deliveries.last.to).to eq ['bill@exmpl.com']
      end

      it "contains the user's name in the body with valid input" do
        post :create, user: Fabricate.attributes_for(:user, full_name: 'Wild Bill')
        expect(ActionMailer::Base.deliveries.last.body).to include 'Wild Bill'
      end

      it "does not send an email with invalid input" do
        post :create, user: Fabricate.attributes_for(:user, password: nil)
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end

  describe "GET show" do
    let(:user) { Fabricate(:user) }

    before { set_current_user }

    it_behaves_like "require_sign_in" do
      let(:action) { get :show, id: user.id }
    end

    it "sets @user" do
      get :show, id: user.id
      expect(assigns(:user)).to eq user
    end
  end

  describe "POST reset_email" do
    context "with invalid email" do
      before { post :reset_email, email: 'invalid@address.com' }

      it "redirects to the forgot password page" do
        expect(response).to redirect_to forgot_password_path
      end

      it "sets a warning message" do
        expect(flash[:warning]).to_not be_blank
      end

      it "does not send an email" do
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end

    context "with valid email" do
      let(:joe) { Fabricate(:user, email: 'joe@mail.com') }

      before { post :reset_email, email: joe.email }
      after { ActionMailer::Base.deliveries = [] }

      it "renders the confirm passowrd reset page." do
        expect(response).to render_template :confirm_password_reset
      end

      it "creates a random password token for the user" do
        expect(joe.reload.password_token).to_not be_blank
      end

      it "sends an email" do
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end

      it "sends an email to the user" do
        expect(ActionMailer::Base.deliveries.last.to).to eq ['joe@mail.com']
      end

      it "sends an email with the password token" do
        expect(ActionMailer::Base.deliveries.last.body).to include joe.reload.password_token
      end
    end
  end

  describe "GET reset_password" do
    context "invalid password token" do
      before do 
        Fabricate(:user)
        get :reset_password, password_token: 'random'
      end

      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end

      it "sets a warning message" do
        expect(flash[:warning]).to_not be_blank
      end
    end

    context "valid password token" do
      let(:susan) { Fabricate(:user) }

      before do
        susan.generate_password_token
        get :reset_password, password_token: susan.password_token
      end

      it "renders the password reset page if the password token matches a user" do
        expect(response).to render_template :reset_password
      end

      it "associates the password token with a user" do
        expect(assigns(:user)).to eq susan
      end

      it "removes the user's password token" do
        expect(susan.reload.password_token).to be_blank
      end
    end
  end
end






