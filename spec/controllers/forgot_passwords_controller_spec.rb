require 'spec_helper'

describe ForgotPasswordsController do
  let(:hank)  { Fabricate(:user) }

#######################################################
  describe 'new' do
    it_behaves_like "does_not_require_sign_in" do
      let(:action) {get :new}
    end
  end

# #######################################################

#   describe 'reset_password' do
#     it_behaves_like "does_not_require_sign_in" do
#       let(:action) {get :reset_password}
#     end
#   end

#######################################################
  describe 'create' do

    it_behaves_like "does_not_require_sign_in" do
      let(:action) {post :create, email: "r@example.com"}
    end

    it "sends a password reset email when the email is valid" do
      post :create, email: hank.email
      expect(ActionMailer::Base.deliveries).to_not be_empty
      ActionMailer::Base.deliveries.clear
    end

    it "does NOT send a password reset email when the email is INvalid" do
      post :create, email: "r@fake.com"
      expect(ActionMailer::Base.deliveries).to be_empty
      ActionMailer::Base.deliveries.clear
    end
  end


end
