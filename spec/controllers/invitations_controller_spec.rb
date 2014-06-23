require "spec_helper"

describe InvitationsController do
  describe "GET new" do
    it "sets @invitation to a new invitation" do
      set_current_user
      get :new
      expect(assigns :invitation).to be_new_record
      expect(assigns :invitation).to be_instance_of Invitation
    end

    it_behaves_like "require_sign_in" do
      let(:action) { get :new }
    end
  end

  describe "POST create" do
    it_behaves_like "require_sign_in" do
      let(:action) { post :create, invitation: { recipient_email: "lucas@toc.com", recipient_name: "Paquito" } }
    end

    context "with valid input" do
      let(:ana) { Fabricate :user }
      before { set_current_user ana }
      after { ActionMailer::Base.deliveries.clear }        

      it "redirects to new invitation page" do
        post :create, invitation: { recipient_email: "lucas@toc.com", recipient_name: "Paquito" }
        expect(response).to redirect_to new_invitation_path
      end

      it "creates an invitation" do
        post :create, invitation: { recipient_email: "lucas@toc.com", recipient_name: "Paquito" }
        expect(Invitation.count).to eq(1) 
      end

      it "sends an email to the recipient_email address" do
        post :create, invitation: { recipient_email: "lucas@toc.com", recipient_name: "Paquito" }
        expect(ActionMailer::Base.deliveries.last.to).to eq(["lucas@toc.com"])  
      end

      it "sends an email containing the user name" do
        post :create, invitation: { recipient_email: "lucas@toc.com", recipient_name: "Paquito" }
        expect(ActionMailer::Base.deliveries.last.body).to include(ana.full_name)        
      end

      it "sends an email containing the invited user name" do
        post :create, invitation: { recipient_email: "lucas@toc.com", recipient_name: "Paquito" }
        expect(ActionMailer::Base.deliveries.last.body).to include("Paquito")              
      end

      it "sends an email with the invitation massage in the content" do
        post :create, invitation: { recipient_email: "lucas@toc.com", recipient_name: "Paquito", invitation_message: "Paquito eres muy grande y muy bien." }
        expect(ActionMailer::Base.deliveries.last.body).to include("Paquito eres muy grande y muy bien.")     
      end

      it "sets the notice" do
        post :create, invitation: { recipient_email: "lucas@toc.com", recipient_name: "Paquito" }
        expect(flash[:notice]).to eq("Your invitation has been sent.")
      end
    end

    context "with invalid input" do
      let(:ana) { Fabricate :user }
      before { set_current_user ana }
      after { ActionMailer::Base.deliveries.clear }    

      it "renders new template" do
        post :create, invitation: { recipient_email: "lucas@toc.com" }  
        expect(response).to render_template :new      
      end

      it "does not send an email if there is no invited user name submited" do
        post :create, invitation: { recipient_email: "lucas@toc.com" }
        expect(ActionMailer::Base.deliveries.last).to be_blank           
      end

      it "does not send an email if there is no invited user email subtimed" do
        post :create, invitation: { recipient_name: "Paquito" }
        expect(ActionMailer::Base.deliveries.last).to be_blank   
      end

      it "sets error message" do
        post :create, invitation: { recipient_name: "Paquito" }
        expect(flash[:error]).to eq("You have to fill Email and Friend's name fields.")
      end

      it "sets @invitation" do
        post :create, invitation: { recipient_name: "Paquito" }
        expect(assigns :invitation).to be_present
      end
    end
  end
end