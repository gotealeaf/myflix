require 'spec_helper'

describe InvitationsController do
  
  describe "GET new" do
    let(:jane) { Fabricate(:user) }
    it 'sets the @invitation instance variable to a new invitation' do
      set_current_user(jane)
      get :new
      expect(assigns(:invitation)).to be_instance_of Invitation
    end
    
    it_behaves_like "require sign in" do
      let(:action) { get :new }
    end
  end# ends GET new
  
  describe "POST create" do
    
    it_behaves_like "require sign in" do
      let(:action) { post :create }
    end
    
    context "valid input" do
    let(:jane) { Fabricate(:user) }
      
      after { ActionMailer::Base.deliveries.clear } # to clear everything after it runs. Matters for the invalid input (where no mails are supposed to be sent out)
      
      it 'should create a new invitation between the current user and the invited friend' do
        set_current_user(jane)
        post :create, invitation: { recipient_email: "joe@example.com", recipient_name: "Joe Bloggs", message: "Join in!" }
        expect(Invitation.count).to eq(1)
      end
      
      it 'should send an email to the friend' do
        set_current_user(jane)
        post :create, invitation: { recipient_email: "joe@example.com", recipient_name: "Joe Bloggs", message: "Join in!" }
        expect(ActionMailer::Base.deliveries.last.to).to eq(["joe@example.com"])
      end 
      
      it 'should redirect to the new invitations page' do
        set_current_user(jane)
        post :create, invitation: { recipient_email: "joe@example.com", recipient_name: "Joe Bloggs", message: "Join in!" }
        expect(response).to redirect_to new_invitation_path
      end
      
      it 'should show the flash success message' do
        set_current_user(jane)
        post :create,  invitation: { recipient_email: "joe@example.com", recipient_name: "Joe Bloggs", message: "Hi, join in!" }
        expect(flash[:success]).not_to be_blank
      end
    end #ends valid input context
    
    context "invalid input" do
      let(:jane) { Fabricate(:user) }
      
      it 'should not create an invitation' do
        set_current_user(jane)
        post :create, invitation: { recipient_email: "joe@example.com" }
        expect(Invitation.count).to eq(0)
      end
      
      it 'should set a flash error message' do
        set_current_user(jane)
        post :create, invitation: { recipient_email: "joe@example.com" }
        expect(flash[:danger]).not_to be_blank
      end
      
      it 'should render the new template' do
        set_current_user(jane)
        post :create, invitation: { recipient_email: "joe@example.com" }
        expect(response).to render_template :new
      end
      
      it 'does not send an email to the friend' do
        set_current_user(jane)
        post :create, invitation: { recipient_email: "joe@example.com" }
        expect(ActionMailer::Base.deliveries).to be_empty
      end
      
      it 'sets the @invitation variable' do
        set_current_user(jane)
        post :create, invitation: { recipient_email: "joe@example.com" }
        expect(assigns(:invitation)).to be_instance_of Invitation
      end
    end
  end
end