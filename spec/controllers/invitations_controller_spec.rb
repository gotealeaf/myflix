require 'spec_helper'

describe InvitationsController  do 

  describe "GET new"  do
    it_behaves_like "requires sign in" do
      let(:action) {get :new}
    end
    context "with a current user" do
      let_current_user
      it "it should create a new invitation" do
        get :new
        expect(assigns(:invitation)).to be_new_record
        expect(assigns(:invitation)).to be_instance_of(Invitation)
      end
    end
  end

  describe "POST create" do
    after {ActionMailer::Base.deliveries.clear}

   it_behaves_like "requires sign in" do
      let(:action) {get :new}
    end
    context " with a current user" do
      let_current_user

      context "and valid inputs" do
        let!(:invite)  {Fabricate.attributes_for(:invitation)}

        it "redirects back to the invite page" do
          post :create, invitation: invite
          expect(response).to redirect_to new_invitation_path
        end
         it "should create a new invitation" do
            post :create, invitation: invite
          expect(Invitation.count).to eq(1)
         end
        it "should set the @invitation variable" do
          post :create, invitation: invite
          expect(assigns(:invitation)).to be_present
        end
        it "should send an invitation email"  do
             post :create, invitation: {recipient_name: "Joe", recipient_email: 'a@b.com', message: 'sage'}
             expect(ActionMailer::Base.deliveries.count).to eq(1)
        end
        it "sets the flash success message" do
          post :create, invitation: invite
          expect(flash[:success]).to be_present
        end
      end

       context "with invalid inputs" do
        before { post :create, invitation: {recipient_name: "Jim"}}
        it "should redirect back to the new page" do
          expect(Invitation.count).to be(0)
        end
        it "should not create a new invitation" do
          expect(Invitation.count).to eq(0)
        end
         it "should not send an invitation email"  do
             expect(ActionMailer::Base.deliveries.count).to eq(0)
        end
         it "sets the flash success message" do
          expect(flash[:error]).to be_present
        end
       end

    end
  end
end