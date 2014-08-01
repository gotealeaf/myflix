require "spec_helper"

describe InvitesController do
  describe "GET new" do
    it "assigns the @invite variable" do
      set_current_user
      get :new
      expect(assigns(:invite)).to be_a_new(Invite)
    end
  end

  describe "POST create" do
    context "with valid input" do
      before do 
        set_current_user
        post :create, invite: { friend_name: "Bob Johnson", friend_email: "bob@test.com", user: current_user }
      end
        
      it "redirects to the home page" do
        expect(response).to redirect_to home_path
      end

      it "saves a new invite to the database" do
        expect(Invite.count).to eq(1)
      end

      it "creates a new invite associated with the signed in user" do
        expect(Invite.first.user).to eq(current_user)
      end

      it "sends an email to the invitee's email" do
        expect(ActionMailer::Base.deliveries.last.to).to eq(["bob@test.com"])
      end

      it "sends the success notice" do
        expect(flash[:notice]).to_not be_empty
      end
    end

    context "with a blank field" do
      it "renders the :new template" do
        set_current_user
        post :create, invite: { friend_name: "Bob Johnson", friend_email: "", user: current_user }
        expect(response).to render_template :new
      end
    end

    #context "with invalid email"????
  end
end