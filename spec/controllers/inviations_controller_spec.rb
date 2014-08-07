require 'spec_helper'

describe InvitationsController do
  let(:current_user) { Fabricate(:user) }
  describe "GET new" do

    it "assigns @invitation" do
     session[:user_id] = current_user.id
     get :new
     expect(assigns(:invitation)).to be_new_record
     expect(assigns(:invitation)).to be_instance_of(Invitation)
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end
  end

  describe "POST create" do

    before { session[:user_id] = current_user.id }

    context "with valid input" do

      before { post :create, invitation: Fabricate.attributes_for(:invitation, inviter_id: current_user.id )}
      after { ActionMailer::Base.deliveries.clear }

      it "redirects to new invitation path" do
        expect(response).to redirect_to new_invitation_path
      end

      it "create a new invitation" do
        expect{
          post :create, invitation: Fabricate.attributes_for(:invitation, inviter_id: current_user.id )
        }.to change(Invitation, :count).by(1)
      end

      it "send out a email to recipient" do
        expect(ActionMailer::Base.deliveries.last.to).to eq([Invitation.last.recipient_email])
      end

      it "set a flash message" do
        expect(flash[:success]).not_to be_blank
      end
    end

    context "with invalid input" do

      before { post :create, invitation: Fabricate.attributes_for(:invitation, recipient_email: "", inviter_id: current_user.id )}
      after { ActionMailer::Base.deliveries.clear }

      it "dont create a new invitation record" do
        expect {
          post :create, invitation: Fabricate.attributes_for(:invitation, recipient_email: "", inviter_id: current_user.id )
        }.not_to change(User, :count)
      end

      it "dont send out email" do
        expect(ActionMailer::Base.deliveries).to be_empty
      end

      it "renders template :new" do
        expect(response).to render_template :new
      end

      it "assigns @invitation" do
        expect(assigns(:invitation)).to be_new_record
        expect(assigns(:invitation)).to be_instance_of Invitation
      end
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :create, invitation: Fabricate.attributes_for(:invitation) }
    end
  end
end
