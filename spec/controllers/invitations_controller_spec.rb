require 'spec_helper'

describe InvitationsController do
  describe 'GET new' do
    it_behaves_like 'require_sign_in' do
      let(:action) { get :new }
    end
  end

  describe 'POST create' do
    it_behaves_like 'require_sign_in' do
      let(:action) { post :create }
    end

    context "with invitee already registered" do
      let(:john) { Fabricate(:user, full_name: 'John Adams', email: 'jadams@example.com') }
      
      before do
        set_current_user
        post :create, full_name: john.full_name, email: john.email, message: 'Join the site!'
      end

      it "redirects to the invitee's page"
      it "does not create a new invitation"
      it "follows the invitee"
      it "sets an alert message"
    end

    context "with invitee not already registered" do
      before do
        set_current_user
        post :create, full_name: 'John Adams', email: 'jadams@example.com', message: 'Join the site!'
      end

      it "redirects to the home page" do
        expect(response).to redirect_to home_path
      end

      it "creates an invitation from the user to the invitee" do
        expect(Invitation.first.user).to eq current_user
        expect(Invitation.first.invitee_email).to eq 'jadams@example.com'
      end

      it "sends an email to the invitee" do
        expect(ActionMailer::Base.deliveries.last.to).to eq ['jadams@example.com']
      end

      it "sets an success message" do
        expect(flash[:success]).to_not be_blank
      end
    end
  end
end