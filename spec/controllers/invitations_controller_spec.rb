require 'spec_helper'

describe InvitationsController do
  
  describe "GET show" do
    it "renders the register page" do
      invitation = Fabricate(:invitation)
      invitation.update_column(:token, '12345')
      get :show, id: '12345'
      expect(response).to render_template('users/new')
    end
    it "sets @friend_email to the friend_email matching the token" do
      invitation = Fabricate(:invitation)
      invitation.update_column(:token, '12345')
      get :show, id: '12345'
      expect(assigns(:friend_email)).to eq(Invitation.first.friend_email)
    end
    it "redirects to the invalid_token_path if the token is not valid" do
       invitation = Fabricate(:invitation)
      invitation.update_column(:token, '12345')
      get :show, id: '1234'
      expect(response).to redirect_to invalid_token_path
    end
  end
  
  describe "POST create" do
    before { set_current_user }
    it_behaves_like "require_sign_in" do
      let(:action) { post :create, friend_name: "Alice Smith", friend_email: "alice@example.com", invitation_message: "Join now!" }
    end
    it "redirects to the invite path" do
      post :create, friend_name: "Alice Smith", friend_email: "alice@example.com", invitation_message: "Join now!"
      expect(response).to redirect_to invite_path
    end
    it "creates a new invitation object" do
      post :create, friend_name: "Alice Smith", friend_email: "alice@example.com", invitation_message: "Join now!"
      expect(Invitation.first).not_to be_nil
    end
    it "associates the new invitation with the current user" do
      post :create, friend_name: "Alice Smith", friend_email: "alice@example.com", invitation_message: "Join now!"
      expect(Invitation.first.user_id).to eq(current_user.id)
    end
    it "associates the new invitation with the friend_email" do
      post :create, friend_name: "Alice Smith", friend_email: "alice@example.com", invitation_message: "Join now!"
      expect(Invitation.first.friend_email).to eq("alice@example.com")
    end
    it "associates the new invitation with a token" do
      post :create, friend_name: "Alice Smith", friend_email: "alice@example.com", invitation_message: "Join now!"
      expect(Invitation.first.token).not_to be_nil
    end
    
    context "friend has already been invited" do
      it "does not create the invitation if one has already been created for that friend_email" do
        Fabricate(:invitation, friend_email: "alice@example.com")
        post :create, friend_name: "Alice Smith", friend_email: "alice@example.com", invitation_message: "Join now!"
        expect(Invitation.all.count).to eq(1)
      end
      it "displays an error message in the flash" do
        Fabricate(:invitation, friend_email: "alice@example.com")
        post :create, friend_name: "Alice Smith", friend_email: "alice@example.com", invitation_message: "Join now!"
        expect(flash[:error]).to eq("That user has already been invited")
      end
    end
    
    context "email sending after invite created" do
      before { ActionMailer::Base.deliveries.clear }
      after { ActionMailer::Base.deliveries.clear }
      
      it "sends an invitation email to the friend_email" do
        post :create, friend_name: "Alice Smith", friend_email: "alice@example.com", invitation_message: "Join now!"
        expect(ActionMailer::Base.deliveries.last.to).to eq(["alice@example.com"])
      end
      it "sends an email containing the friend_name" do
        post :create, friend_name: "Alice Smith", friend_email: "alice@example.com", invitation_message: "Join now!"
        expect(ActionMailer::Base.deliveries.last).to have_content("Alice Smith")
      end
      it "sends an email containing the invitation_message" do
        post :create, friend_name: "Alice Smith", friend_email: "alice@example.com", invitation_message: "Join now!"
        expect(ActionMailer::Base.deliveries.last).to have_content("Join now!")
      end
      it "sends an email containing the inviting user's name" do
        post :create, friend_name: "Alice Smith", friend_email: "alice@example.com", invitation_message: "Join now!"
        expect(ActionMailer::Base.deliveries.last).to have_content(current_user.full_name)
      end
      it "displays a flash notice that the user invitation was sent" do
        post :create, friend_name: "Alice Smith", friend_email: "alice@example.com", invitation_message: "Join now!"
        expect(flash[:success]).to have_content("Your invitation has been sent")
      end
    end
  end
  
end