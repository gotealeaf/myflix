require 'spec_helper'

describe ForgotPasswordsController do
  describe "POST create" do
    context "with invalid email" do
      before { post :create, email: 'invalid@address.com' }
      after { ActionMailer::Base.deliveries = [] }

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

      before { post :create, email: joe.email }
      after { ActionMailer::Base.deliveries = [] }

      it "renders the confirm passowrd reset page." do
        expect(response).to render_template :create
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

  describe "GET edit" do
    context "with invalid password token" do
      before do 
        Fabricate(:user)
        get :edit, password_token: 'random'
      end

      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end

      it "sets a warning message" do
        expect(flash[:warning]).to_not be_blank
      end
    end

    context "with valid password token" do
      let(:susan) { Fabricate(:user) }

      before do
        susan.generate_password_token
        get :edit, password_token: susan.password_token
      end

      it "renders the password reset page if the password token matches a user" do
        expect(response).to render_template :edit
      end

      it "associates the password token with a user" do
        expect(assigns(:user)).to eq susan
      end

      it "does not remove the user's password token" do
        expect(susan.reload.password_token).to_not be_blank
      end
    end
  end
  
  describe "POST update" do
    context "with invalid password token" do
      before do 
        Fabricate(:user)
        post :update, password_token: 'random', password: 'password', password_confirmation: 'password'
      end

      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end

      it "sets a warning message" do
        expect(flash[:warning]).to_not be_blank
      end
    end

    context "with valid password token" do
      let(:suzy) { Fabricate(:user) }

      before do
        suzy.generate_password_token
        post :update, password_token: suzy.password_token, password: 'password2', password_confirmation: 'password2'
      end

      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end

      it "sets success message" do
        expect(flash[:success]).to_not be_blank
      end

      it "associates the password token with a user" do
        expect(assigns(:user)).to eq suzy
      end

      it "updates the user's password" do
        expect(suzy.reload.authenticate('password2')).to be_true
      end

      it "removes the user's password token" do
        expect(suzy.reload.password_token).to be_blank
      end
    end
  end
end