require 'spec_helper'

describe InvitationsController do
  describe "GET new" do
    context "user authenticated" do
      it "sets the invitation instance variable" do
        alice = Fabricate(:user)
        set_current_user(alice)
        get :new
        expect(assigns(:invitation)).to be_instance_of(Invitation)
      end
    end

    context "user not authenticated" do
      before do 
        alice = Fabricate(:user)
        get :new
      end

      it_behaves_like "requires login"
    end
  end 

  describe "POST create" do
    context "user authenticated" do
      context "valid_input" do
        after { ActionMailer::Base.deliveries.clear }

        it "sets a success flash message" do
          alice = Fabricate(:user)
          set_current_user(alice)
          invitation = Fabricate.build(:invitation)
          post :create, invitation: invitation.attributes
          expect(flash[:success]).to eq("Your invitation has been emailed to #{invitation.full_name}")
        end 

        it "redirects to the home page" do
          alice = Fabricate(:user)
          set_current_user(alice)
          invitation = Fabricate.build(:invitation)
          post :create, invitation: invitation.attributes
          expect(response).to redirect_to home_path
        end

        it "saves the invitation to the database" do
          alice = Fabricate(:user)
          set_current_user(alice)
          invitation = Fabricate.build(:invitation)
          post :create, invitation: invitation.attributes
          expect(Invitation.count).to eq(1)
        end

        it "sends out an invitation email" do 
          alice = Fabricate(:user)
          set_current_user(alice)
          invitation = Fabricate.build(:invitation)
          post :create, invitation: invitation.attributes
          expect(ActionMailer::Base.deliveries).not_to be_empty
        end

        it "sends the invitation email to the address input by the user" do
          alice = Fabricate(:user)
          set_current_user(alice)
          invitation = Fabricate.build(:invitation)
          post :create, invitation: invitation.attributes
          message = ActionMailer::Base.deliveries.last
          expect(message.to).to eq([invitation.email])
        end

        it "sends an invitation email that contains the user's message" do
          alice = Fabricate(:user)
          set_current_user(alice)
          invitation = Fabricate.build(:invitation)
          post :create, invitation: invitation.attributes
          message = ActionMailer::Base.deliveries.last
          expect(message.body).to include(invitation.message)
        end

        it "sends an invitation email that contains a link to the registration page" do 
          alice = Fabricate(:user)
          set_current_user(alice)
          invitation = Fabricate.build(:invitation)
          post :create, invitation: invitation.attributes
          message = ActionMailer::Base.deliveries.last
          expect(message.body).to include("Click here to join!")
        end
      end

      context "invalid input" do
        after { ActionMailer::Base.deliveries.clear }
        
        it "renders the new invitation page again" do
          alice = Fabricate(:user)
          set_current_user(alice)
          bad_invitation = Fabricate.build(:bad_invitation)
          post :create, invitation: bad_invitation.attributes
          expect(response).to render_template :new
        end

        it "does not send out an email" do
          alice = Fabricate(:user)
          set_current_user(alice)
          bad_invitation = Fabricate.build(:bad_invitation)
          post :create, invitation: bad_invitation.attributes
          expect(ActionMailer::Base.deliveries).to be_empty
        end

        it "does not save an invitation to the database" do
          alice = Fabricate(:user)
          set_current_user(alice)
          bad_invitation = Fabricate.build(:bad_invitation)
          post :create, invitation: bad_invitation.attributes
          expect(Invitation.count).to eq(0)
        end
      end
    end

    context "user not authenticated" do
      before { post :create }
      it_behaves_like "requires login"
    end
  end

  describe "GET show" do
    it "creates a new user with attributes from the invitation" do
      alice = Fabricate(:user)
      set_current_user(alice)
      invitation = Fabricate(:invitation)
      get :show, id: invitation.id
      expect(assigns(:user).full_name).to eq(invitation.full_name)
      expect(assigns(:user).email).to eq(invitation.email)
    end

    it "renders the registration page" do
      alice = Fabricate(:user)
      set_current_user(alice)
      invitation = Fabricate(:invitation)
      get :show, id: invitation.id
      expect(response).to render_template 'users/new'
    end
  end
end