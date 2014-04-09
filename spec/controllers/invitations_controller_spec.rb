require 'spec_helper'

describe InvitationsController do
  describe "GET new" do
    it "renders the new template when current_user is logged in" do
      set_current_user
      get :new
      expect(response).to render_template(:new)
    end
  end
  
  describe "POST create" do
    context "with valid inputs" do
      it "redirects current_user to videos path" do
        set_current_user
        post :create, email: "elena@example.com", full_name: "Elena Smith", description: "Join this cool site." 

        message = ActionMailer::Base.deliveries
        expect(response).to redirect_to(videos_path)
      end

      it "redirects current_user to videos path with a flash notice" do
        set_current_user
        post :create, email: "elena@example.com", full_name: "Elena Smith", description: "Join this cool site." 

        message = ActionMailer::Base.deliveries
        expect(flash[:notice]).to eq("Your invitation has been sent.")
      end

      it "sends an email to the user" do
        set_current_user
        post :create, email: "elena@example.com", full_name: "Elena Smith", description: "Join this cool site." 

        message = ActionMailer::Base.deliveries
        expect(message.last.to).to eq(["elena@example.com"])
      end

      it "saves the email address of the current user and of the guest" do
        bob = Fabricate(:user)
        set_current_user(bob)
        #binding.pry
        post :create, email: "elena@example.com", full_name: "Elena Smith", description: "Join this cool site." 

        message = ActionMailer::Base.deliveries
        expect(Invitation.first.inviter_email).to eq(bob.email)
        expect(Invitation.first.guest_email).to eq("elena@example.com")
      end
    end

    context "with invalid inputs" do
      it "renders a new template with error alerts" do
        post :create, full_name: "Elena Smith", description: "Join this cool site." 
        message = ActionMailer::Base.deliveries
        expect(flash[:notice]).to eq("Please fill out the form entirely.")
      end
    end
  end

end