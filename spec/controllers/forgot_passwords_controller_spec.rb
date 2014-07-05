require 'rails_helper.rb'

describe ForgotPasswordsController do
  describe "POST create" do
    context "with blank input"
      it "redirects to the forgot password page" do
        post :create, email: ''
        expect(response).to redirect_to forgot_password_path
      end

      it "shows error message" do
        post :create, email: ''
        expect(flash[:danger]).to eq("Email can't be blank.")
      end

    context "with existing email"
      it "redirects to the forgot password confirmation page" do
        joe = Fabricate(:user)
        post :create, email: joe.email
        expect(response).to redirect_to forgot_password_confirmation_path
      end

      it "sends email to the email address submitted" do
        joe = Fabricate(:user)
        post :create, email: joe.email
        expect(ActionMailer::Base.deliveries.last.to).to eq([joe.email])
      end

    context "with non-existing email" do
      it "redirects to the forgot password page" do
        post :create, email: "joe@test.com"
        expect(response).to redirect_to forgot_password_path
      end

      it "shows error message" do
        post :create, email: "joe@test.com"
        expect(flash[:danger]).to eq("There is no user registered with that email address.")
      end
    end
  end
end
