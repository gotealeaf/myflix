require 'spec_helper'

describe InvitationsController do
  describe "GET new" do
    it "sets @invitation a new invitation" do
      set_current_user
      get :new
      assigns(:invitation).should be_instance_of Invitation 
    end

    it_behaves_like "require_sign_in" do
      let(:action) { get :new }
    end
  end
  describe "POST create" do
    it_behaves_like "require_sign_in" do
      let(:action) { post :create }
    end

    context "with valid input" do
      after { ActionMailer::Base.deliveries.clear }

      it "redirects to the invitation new page" do
        set_current_user
        post :create, invitation: { recipient_name: "Joe Smith", recipient_email: "joe@example.com", message: "Hey Join this site!"}
        response.should redirect_to new_invitation_path
      end
      it "creates an invitation" do
        set_current_user
        post :create, invitation: { recipient_name: "Joe Smith", recipient_email: "joe@example.com", message: "Hey Join this site!"}
        Invitation.count.should == 1
      end

      it "sets the flash success message" do 
        set_current_user
        post :create, invitation: { recipient_name: "Joe Smith", recipient_email: "joe@example.com", message: "Hey Join this site!"}
        flash[:success].should be_present
      end
      it "sends an email to recipient" do
        set_current_user
        post :create, invitation: { recipient_name: "bob", recipient_email: "bob@email.com", message: "Join this cool site"}
        ActionMailer::Base.deliveries.last.to.should == ["bob@email.com"]
      end
    end
    context "with invalid input" do 
      it "renders the new template" do
        set_current_user
        post :create, invitation: {  recipient_email: "bob@email.com", message: "Join this cool site"}
        response.should render_template :new
      end
      it "does not create an inviation" do
        set_current_user
        post :create, invitation: {  recipient_email: "bob@email.com", message: "Join this cool site"}
        Invitation.count.should == 0
      end
      it "does not send an email" do
        set_current_user
        post :create, invitation: {  recipient_email: "bob@email.com", message: "Join this cool site"}
        ActionMailer::Base.deliveries.should be_empty
      end
      it "sets the flash error message" do
        set_current_user
        post :create, invitation: {  recipient_email: "bob@email.com", message: "Join this cool site"}
        flash[:error].should be_present
      end
      it "sets the @invitation" do 
        set_current_user
        post :create, invitation: {  recipient_email: "bob@email.com", message: "Join this cool site"}
        assigns(:invitation).should be_present
      end
    end
  end
end