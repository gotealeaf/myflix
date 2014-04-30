require 'spec_helper'

describe InvitationsController do
  describe "GET new" do
    context "user authenticated" do
      it "sets @invitation to a new invitation" do
        alice = Fabricate(:user)
        set_current_user(alice)
        get :new
        expect(assigns(:invitation)).to be_new_record
        expect(assigns(:invitation)).to be_instance_of(Invitation)
      end
    end

    context "user not authenticated" do
      before { get :new }
      it_behaves_like "requires login"
    end
  end 

  describe "POST create" do
    context "user authenticated" do
      context "valid_input" do
        around { ActionMailer::Base.deliveries.clear }

        it "sets a success flash message" do
          alice = Fabricate(:user)
          set_current_user(alice)
          invitation = Fabricate.build(:invitation)
          post :create, invitation: invitation.attributes
          expect(flash[:success]).to eq("Your invitation has been emailed to 
                                         #{invitation.recipient_name}")
        end 

        it "redirects to the invitation page" do
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

        it "sends an email to the address input by the user" do
          alice = Fabricate(:user)
          set_current_user(alice)
          invitation = Fabricate.build(:invitation)
          post :create, invitation: invitation.attributes
          message = ActionMailer::Base.deliveries.last
          expect(message.to).to eq([invitation.recipient_email])
        end

        it "sends an email that contains the user's message" do
          alice = Fabricate(:user)
          set_current_user(alice)
          invitation = Fabricate.build(:invitation)
          post :create, invitation: invitation.attributes
          message = ActionMailer::Base.deliveries.last
          expect(message.body).to include(invitation.message)
        end

        it "sends an email that contains a link to the register page" do 
          alice = Fabricate(:user)
          set_current_user(alice)
          invitation = Fabricate.build(:invitation)
          post :create, invitation: invitation.attributes
          message = ActionMailer::Base.deliveries.last
          expect(message.body).to include("Click here to join!")
        end
      end

      context "invalid input" do
        around { ActionMailer::Base.deliveries.clear }
        
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

        # no flash error set due to using f.alert_message w/bootstrap_form_for

        it "sets @invitation" do
          alice = Fabricate(:user)
          set_current_user(alice)
          bad_invitation = Fabricate.build(:bad_invitation)
          post :create, invitation: bad_invitation.attributes
          expect(assigns(:invitation)).to eq(bad_invitation.merge!(inviter_id: 
                                                                   alice.id))
        end
      end
    end

    context "user not authenticated" do
      before { post :create }
      it_behaves_like "requires login"
    end
  end
end