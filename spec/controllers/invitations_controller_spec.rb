require 'spec_helper'

describe InvitationsController do
  describe "GET new" do
    it "sets @invitation to a new invitation" do
      set_current_user
      get :new
      expect(assigns(:invitation)).to be_new_record
      expect(assigns(:invitation)).to be_instance_of Invitation
    end

    it_behaves_like "require sign in" do
      let(:action) { get :new }
    end
  end

  describe "POST create" do
    it_behaves_like "require sign in" do
      let(:action) { post :create }
    end

    after { ActionMailer::Base.deliveries.clear }

    context "with valid input" do
      before do 
        set_current_user 
        post :create, invitation: { recipient_name: "Joe Smith", recipient_email: "joe@example.com", message: "Hey join myflix!" }
      end

      it "redirects to the invitation new page" do
        expect(response).to redirect_to new_invitation_path
      end

      it "creates an invitation" do        
        expect(Invitation.count).to eq(1)
      end

      it "sends an email to the recipient" do
        expect(ActionMailer::Base.deliveries.last.to).to eq(["joe@example.com"])
      end
      
      it "sets the flash success message" do
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid input" do
      before do
        set_current_user 
        post :create, invitation: { recipient_email: "joe@example.com", message: "Hey join myflix!" }
      end

      it "renders the :new template" do
        expect(response).to render_template(:new)
      end

      it "does not create an invitation" do
        expect(Invitation.count).to eq(0)
      end

      it "does not send out an email" do
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end

      it "sets the flash error message" do
        expect(flash[:error]).to be_present
      end

      it "sets @invitation" do
        expect(assigns(:invitation)).to be_present
      end      
    end
  end
end