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

      it "renders the passowrd reset page." do
        expect(response).to render_template :create
      end

      it "sends an email to the user" do
        expect(ActionMailer::Base.deliveries.last.to).to eq ['joe@mail.com']
      end

      it "sends an email with the password token" do
        expect(ActionMailer::Base.deliveries.last.body).to include joe.reload.token
      end
    end
  end
end