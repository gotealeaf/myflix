require "rails_helper"

describe ForgotPasswordsController do
  describe "POST create" do
    context "with blank input" do
      before { post :create, email: "" }

      it "redirects to the forgot password page" do
        expect(response).to redirect_to(forgot_password_path)
      end

      it "shows an error message" do
        expect(flash[:danger]).to eq("Email cannot be blank")
      end
    end

    context "with existing email" do
      it "redirects to the forgot password confirmation page" do
        Fabricate(:user, email: "test@email.com")

        post :create, email: "test@email.com"

        expect(response).to redirect_to(forgot_password_confirmation_path)
      end

      it "sends an email" do
        Fabricate(:user, email: "test@email.com")

        post :create, email: "test@email.com"

        expect(ActionMailer::Base.deliveries.last.to).to eq(["test@email.com"])
      end
    end

    context "with non-existing email" do
      before { post :create, email: "test@email.com" }

      it "redirects to the forgot password page" do
        expect(response).to redirect_to forgot_password_path
      end

      it "shows an error message" do
        expect(flash[:danger]).to eq("There is no user with that email in the system")
      end
    end
  end #POST create
end