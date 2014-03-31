require "spec_helper"

describe InvitationsController do
  describe "GET new" do
    context "with authenticated users" do
      it "should set @invitation to a new invitation" do
        set_current_user
        get :new
        expect(assigns(:invitation)).to be_new_record
        expect(assigns(:invitation)).to be_instance_of Invitation
      end
    end

    context "with unauthenticated users" do
      it_behaves_like "requires sign in" do
        let (:action) { get :new }
      end
    end
  end

  describe "POST create" do
    context "with authenticated users" do
      after { ActionMailer::Base.deliveries.clear }
      context "with valid input" do
        it "should redirect to invitation new page" do
          set_current_user
          post :create, invitation: { recipient_email: "linda@123.com", recipient_name: "linda", message: "Hey join myfilx!" }
          expect(response).to redirect_to new_invitation_path
        end
        it "create a invitation" do
          set_current_user
          post :create, invitation: { recipient_email: "linda@123.com", recipient_name: "linda", message: "Hey join myfilx!" }
          expect(Invitation.count).to eq(1)
        end
        it "should send an email to recipient" do
          set_current_user
          post :create, invitation: { recipient_email: "linda@123.com", recipient_name: "linda", message: "Hey join myfilx!" }
          expect(ActionMailer::Base.deliveries.last.to).to eq(["linda@123.com"])
        end
        it "should set flash success message" do
          set_current_user
          post :create, invitation: { recipient_email: "linda@123.com", recipient_name: "linda", message: "Hey join myfilx!" }
          expect(flash[:info]).to be_present
        end
      end

      context "with invalid input" do
        it "should render invitation new page" do
          set_current_user
          post :create, invitation: { recipient_email: "linda@123.com", recipient_name: "linda" }
          expect(response).to render_template :new
        end
        it "should not create a invitation" do
          set_current_user
          post :create, invitation: { recipient_email: "linda@123.com", recipient_name: "linda" }
          expect(Invitation.count).to eq(0)
        end
        it "should not send out an email" do
          set_current_user
          post :create, invitation: { recipient_email: "linda@123.com", recipient_name: "linda" }
          expect(ActionMailer::Base.deliveries).to be_empty
        end
        it "should set flash danger message" do
          set_current_user
          post :create, invitation: { recipient_email: "linda@123.com", recipient_name: "linda" }
          expect(flash[:danger]).to be_present
        end
        it "should set @invitation variable" do
          set_current_user
          post :create, invitation: { recipient_email: "linda@123.com", recipient_name: "linda" }
          expect(assigns(:invitation)).to be_present
        end
      end
    end

    context "with unauthenticated users" do
      it_behaves_like "requires sign in" do
        let(:action) { post :create, invitation: { recipient_email: "linda@123.com", recipient_name: "linda" } }
      end
    end
  end
end
