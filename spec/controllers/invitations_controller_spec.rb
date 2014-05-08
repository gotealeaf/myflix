require 'spec_helper'

describe InvitationsController do
  describe 'GET new' do
    it_behaves_like 'require_sign_in' do
      let(:action) { get :new }
    end

    it "sets @invitation to a new invitation" do
      set_current_user
      get :new
      expect(assigns(:invitation)).to be_new_record
      expect(assigns(:invitation)).to be_instance_of Invitation
    end
  end

  describe 'POST create' do
    it_behaves_like 'require_sign_in' do
      let(:action) { post :create }
    end

    context "with invalid input" do
      before do
        set_current_user
        post :create, invitation: { invitee_email: 'jadams@example.com', invitee_name: nil, message: 'Hello' }
      end

      it "redirects to the invite page" do
        expect(response).to render_template :new
      end

      it "does not create the invitation" do
        expect(Invitation.first).to be_blank
      end

      it "does not send out an email" do
        expect(ActionMailer::Base.deliveries.last).to be_blank
      end

      it "sets errors on the invitation" do
        expect(assigns(:invitation)).to have(1).error_on(:invitee_name)
      end
    end

    context "with valid input" do
      before do
        set_current_user
        post :create, invitation: { invitee_email: 'jadams@example.com', invitee_name: 'John Adams', message: 'Hello' }
      end

      after { ActionMailer::Base.deliveries = [] }

      it "redirects to the home page" do
        expect(response).to redirect_to home_path
      end

      it "creates an invitation from the user to the invitee" do
        expect(Invitation.first.inviter).to eq current_user
        expect(Invitation.first.invitee_email).to eq 'jadams@example.com'
      end

      it "sends an email to the invitee with register link" do
        expect(ActionMailer::Base.deliveries.last.to).to eq ['jadams@example.com']
        expect(ActionMailer::Base.deliveries.last.body).to include '/register'
      end

      it "sets an success message" do
        expect(flash[:success]).to_not be_blank
      end
    end
  end
end