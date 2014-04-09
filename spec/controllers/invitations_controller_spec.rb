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
        post :create, email: "elena@example.com", full_name: "Elena Smith", description: "Join this cool site." 
        message = ActionMailer::Base.deliveries
        expect(response).to redirect_to(videos_path)
      end

      it "redirects current_user to videos path with a flash notice" do
        post :create, email: "elena@example.com", full_name: "Elena Smith", description: "Join this cool site." 
        message = ActionMailer::Base.deliveries
        expect(flash[:notice]).to eq("Your invitation has been sent.")
      end

      it "sends an email to the user" do
        post :create, email: "elena@example.com", full_name: "Elena Smith", description: "Join this cool site." 
        message = ActionMailer::Base.deliveries
        expect(message.last.to).to eq(["elena@example.com"])
      end
    end

    context "with invalid inputs" do
      it "renders a new template with error alerts"
    end
  end

end