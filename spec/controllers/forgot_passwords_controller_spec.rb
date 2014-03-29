require "spec_helper"

describe ForgotPasswordsController do
  describe "POST create" do
    context "with valid input" do
      it "should redirect to forgot password confirmation page" do
          desmond = Fabricate(:user)
          post :create, email: desmond.email
          expect(response).to redirect_to forgot_password_confirmation_path
      end
      it "should send out an email to the email address" do
          desmond = Fabricate(:user)
          post :create, email: desmond.email
          expect(ActionMailer::Base.deliveries.last.to).to eq([desmond.email])
      end
    end

    context "with invalid input" do
      context "with blank input" do
        it "should redirect to forgot password page" do
          post :create, email: ''
          expect(response).to redirect_to forgot_password_path
        end
        it "should show an error message" do
          post :create, email: ''
          expect(flash[:danger]).to eq("Email cannot be blank!")
        end
      end

      context "with non-existing email address" do
        it "should redirect to forgot password page" do
          post :create, email: 'linda@126.com'
          expect(response).to redirect_to forgot_password_path
        end
        it "should show an error message" do
          post :create, email: 'linda@126.com'
          expect(flash[:danger]).to eq("There is no user with this email in the system!")
        end
      end
    end
  end
end
