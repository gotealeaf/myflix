require 'spec_helper'

describe InvitationsController do

  let(:hank) { Fabricate(:user) }


##########################################################

  describe 'GET new' do

    it_behaves_like "require_sign_in" do
      let(:action) {post :create}
    end

    it "generates a new record" do
      set_current_user(hank)
      get :new
      assigns(:invitation).should be_instance_of(Invitation)
    end
  end
##########################################################
  describe "POST create" do
    
    after do
      ActionMailer::Base.deliveries.clear
    end

    it_behaves_like "require_sign_in" do
      let(:action) {post :create}
    end

    context "with valid input" do
      it "creates an invitation" do
        set_current_user(hank)
        post :create, invitation: {"recipient_name"=>"r", "recipient_email"=>"a@b.com", "message"=>"Hi"}
        expect(Invitation.count).to eq(1)
      end

      it "sends an email to the recipient" do
        set_current_user(hank)
        post :create, invitation: {"recipient_name"=>"r", "recipient_email"=>"a@b.com", "message"=>"Hi"}
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end

        
      it "sends the email to the right person" do
        set_current_user(hank)
        post :create, invitation: {"recipient_name"=>"r", "recipient_email"=>"a@b.com", "message"=>"Hi"}
        expect(ActionMailer::Base.deliveries.last.to).to eq(["rick.heller@yahoo.com"])
      end

      it "redirects to the new page" do
        set_current_user(hank)
        post :create, invitation: {"recipient_name"=>"r", "recipient_email"=>"a@b.com", "message"=>"Hi"}
        response.should redirect_to new_invitation_path
      end

      it "sends sets the success message" do
        set_current_user(hank)
        post :create, invitation: {"recipient_name"=>"r", "recipient_email"=>"a@b.com", "message"=>"Hi"}
        expect(flash[:notice]).to be_present
      end


    end

    context "with INvalid input" do
      it "does NOT creates an invitation" do
        set_current_user(hank)
        post :create, invitation: {"recipient_name"=>"r", "message"=>"Hi"}
        expect(Invitation.count).to eq(0)
      end

      it "sets the error message" do
        set_current_user(hank)
        post :create, invitation: {"recipient_name"=>"r", "message"=>"Hi"}
        expect(flash[:error]).to be_present
      end

      it "returns to the new page" do
        set_current_user(hank)
        post :create, invitation: {"recipient_name"=>"r", "message"=>"Hi"}
        expect(response).to render_template :new
       end
    end
    
    it "sets the instance variable" do
      set_current_user(hank)
      post :create, invitation: {"recipient_name"=>"r", "message"=>"Hi"}
      assigns(:invitation).should be_instance_of(Invitation)
    end



  end

end
