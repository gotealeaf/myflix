require "rails_helper"

describe InvitationsController do
  describe "GET new" do
    it_behaves_like "require sign in" do
      let(:action) { get :new }
    end

    it "sets @invitation" do
      set_current_user
      get :new
      expect(assigns(:invitation)).to be_new_record
      expect(assigns(:invitation)).to be_instance_of Invitation
    end
  end #GET new

  describe "POST create" do
    it_behaves_like "require sign in" do
      let(:action) { post :create }
    end

    context "with valid inputs" do
      after { ActionMailer::Base.deliveries.clear }

      it "redirects to the invitation page" do
        set_current_user
        post :create, invitation: { recipient_name: "Joe", recipient_email: "joe@test.com", message: "Hello Joe!" }
        expect(response).to redirect_to new_invitation_path
      end

      it "creates an invitation" do
        set_current_user
        post :create, invitation: { recipient_name: "Joe", recipient_email: "joe@test.com", message: "Hello Joe!" }
        expect(Invitation.count).to eq(1)
      end
      
      it "sends an email to the recipient" do
        set_current_user
        post :create, invitation: { recipient_name: "Joe", recipient_email: "joe@test.com", message: "Hello Joe!" }
        expect(ActionMailer::Base.deliveries.last.to).to eq(["joe@test.com"])
      end

      it "sets the flash message" do
        set_current_user
        post :create, invitation: { recipient_name: "Joe", recipient_email: "joe@test.com", message: "Hello Joe!" }
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid inputs" do
      it "renders the :new template" do
        set_current_user
        post :create, invitation: { recipient_email: "joe@test.com" }
        expect(response).to render_template(:new)
      end

      it "sets @invitation" do
        set_current_user
        post :create, invitation: { recipient_email: "joe@test.com" }
        expect(assigns(:invitation)).to be_present
      end

      it "does not create an invitation" do
        set_current_user
        post :create, invitation: { recipient_email: "joe@test.com" }
        expect(Invitation.count).to eq(0)
      end

      it "does not send an email" do
        set_current_user
        post :create, invitation: { recipient_email: "joe@test.com" }
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end

      it "sets the flash message" do
        set_current_user
        post :create, invitation: { recipient_email: "joe@test.com" }
        expect(flash[:danger]).to be_present
      end
    end
  end #POST create
end


