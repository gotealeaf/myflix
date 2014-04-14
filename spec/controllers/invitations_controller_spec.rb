require 'spec_helper'

describe InvitationsController do
  describe "GET new" do
    it "renders the new template when current_user is logged in" do
      set_current_user
      get :new
      expect(assigns(:invitation)).to be_instance_of(Invitation)
    end
  end
  
  describe "POST create" do
    context "with valid inputs" do
      after(:each) { ActionMailer::Base.deliveries.clear } 
      it "creates an invitation" do
        set_current_user
        post :create, invitation: {guest_email: "elena@example.com", guest_name: "Elena Smith", message: "Join this cool site." }
        expect(Invitation.count).to eq(1)
      end

      it "redirects current_user to the new invitation view" do
        set_current_user
        post :create, invitation: {guest_email: "elena@example.com", guest_name: "Elena Smith", message: "Join this cool site." }

        expect(response).to redirect_to(new_invitation_path)
      end

      it "redirects current_user with a flash notice" do
        set_current_user
        post :create, invitation: { guest_email: "elena@example.com", guest_name: "Elena Smith", message: "Join this cool site." }

        expect(flash[:notice]).to eq("Your invitation has been sent.")
      end

      it "sends an invitation to a guest" do
        set_current_user
        post :create, invitation: { guest_email: "elena@example.com", guest_name: "Elena Smith", message: "Join this cool site." }

        message = ActionMailer::Base.deliveries
        expect(message.last.to).to eq(["elena@example.com"])
      end

      it "saves the email address of the current user and of the guest" do
        bob = Fabricate(:user)
        set_current_user(bob)
        post :create, invitation: { guest_email: "elena@example.com", guest_name: "Elena Smith", message: "Join this cool site." }

        expect(Invitation.first.inviter).to eq(bob)
        expect(Invitation.first.guest_email).to eq("elena@example.com")
      end

    end

    context "with invalid inputs" do
      it "renders a new template with error alerts" do
        set_current_user
        post :create, invitation: { guest_name: "Elena Smith", message: "Join this cool site." }
        
        expect(response).to render_template(:new)
        expect(flash[:notice]).to eq("Please fill out the form entirely.")
      end

      it "does not create an invitation" do
        set_current_user
        post :create, invitation: {guest_name: "Elena Smith", message: "Join this cool site." }
        expect(Invitation.count).to eq(0)
      end

      it "does not send out an email" do
        set_current_user
        post :create, invitation: {guest_name: "Elena Smith", message: "Join this cool site." }

        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end

      it "sets the @invitation" do
        set_current_user
        post :create, invitation: {guest_name: "Elena Smith", message: "Join this cool site." }

        expect(assigns(:invitation)).to be_present
      end
    end
  end
end