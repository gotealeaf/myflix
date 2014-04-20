require 'spec_helper'

describe InvitationsController do

  describe "GET new" do
    context "for signed in users" do
      let(:joe) { Fabricate(:user) }
      before do
        sign_in_user
        get :new
      end

      it "renders the new invitation template" do
        expect(response).to render_template "new"
      end
      it "loads the @invitation variable" do
        expect(assigns(:invitation)).to be_a_new Invitation
      end
    end

    context "for guest users (not signed in)" do
      it_behaves_like "require_signed_in" do
        let(:verb_action) { get :new }
      end
    end
  end

  describe "POST create" do
    context "for signed in users" do
      let(:joe) { Fabricate(:user) }
      before { sign_in_user(joe) }
      after { ActionMailer::Base.deliveries.clear }

      context "with valid form inputs" do
        before { post :create, { invitation: { friend_name:   "jen",
                                 friend_email:  "jen@example.com",
                                 message:       "Please join!"} } }
        it "redirects to the new invitation action" do
          expect(response).to redirect_to invite_path
        end
        it "flashes a message saying that the invite was sent" do
          expect(flash[:notice]).to be_present
        end
        it "loads the @user instance variable" do
          expect(assigns(:user)).to eq(joe)
        end
        it "loads the @invitation instance variable" do
          expect(assigns(:invitation)).to be_valid
        end
        it "makes a new invitation" do
          expect(Invitation.count).to eq(1)
        end
        it "makes a new invitation with token" do
          expect(Invitation.first.token).to_not be_nil
        end

        context "sending invite emails" do
          it "sends an email to the invited user's email" do
            expect(ActionMailer::Base.deliveries.count).to eq(1)
          end
          it "sends an email with a subject regarding the invitation" do
            expect(ActionMailer::Base.deliveries.last.to).to eq(["jen@example.com"])
          end
          it "sends an email with the inviter's message in the body" do
            expect(ActionMailer::Base.deliveries.last.parts.first.body.raw_source).to include("Please join!")
          end
        end
      end

      context "with invite to an existing user email" do
        let(:joe) { Fabricate(:user) }
        before { post :create, { invitation: { friend_name:   "joe",
                                 friend_email:  joe.email,
                                 message:       "Please join!"} } }

        it "should not create an invitation for a user email already registered" do
          expect(Invitation.count).to eq(0)
        end
      end

      context "with invalid form inputs" do
        before { post :create, { invitation: { friend_name:   "jen",
                                 friend_email:  "",
                                 message:       "Please join!"} } }

        it "renders the new template for errors" do
          expect(response).to render_template "new"
        end
        it "flashes an error banner to fix errors" do
          expect(flash[:error]).to be_present
        end
        it "does not make an invitation" do
          expect(Invitation.all.count).to eq(0)
        end
        it "does not send an email" do
          expect(ActionMailer::Base.deliveries.count).to eq(0)
        end
      end
    end

    context "for guest users (not signed in)" do
      it_behaves_like "require_signed_in" do
        let(:verb_action) { post :create }
      end
    end
  end
end
