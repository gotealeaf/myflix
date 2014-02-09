require 'spec_helper'

describe ResetPasswordController do
  describe "POST create" do
    before { Fabricate(:user, email: "alice@example.com") }
    before { ActionMailer::Base.deliveries.clear }
    context "valid email" do
      it "redirects to the Confirm Password Reset page" do
        post :create, email: "alice@example.com"
        expect(response).to redirect_to(confirm_password_path)
      end
      it "sends out the email" do
        post :create, email: "alice@example.com"
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end
      it "sends to the right recipient" do
        post :create, email: "alice@example.com"
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq(['alice@example.com'])
      end
      it "has the right content" do
        post :create, email: "alice@example.com"
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to include('Please reset your password')
      end
    end
    context "invalid email" do
      it "does not send an email if there is no user with that email" do
        post :create, email: "bob@example.com"
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end
      it "should not send an email if the email is blank" do
        post :create, email: ""
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end
      it "should show an error message if email doesn't exist in database" do
        post :create, email: "bob@example.com"
        expect(flash[:error]).to be_present
      end
      it "should redirect to forgot_password_path if email doesn't exist" do
        post :create, email: "bob@example.com"
        expect(response).to redirect_to forgot_password_path
      end
    end
  end
end