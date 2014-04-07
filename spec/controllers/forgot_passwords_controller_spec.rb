require 'spec_helper'

describe ForgotPasswordsController do

  describe "GET new" do
    context "for signed out users" do
      context "for a user with a forgotten password" do
        let(:joe) { Fabricate(:user) }

        it "renders the forgot_password page" do
          get :new
          expect(response).to render_template 'new'
        end
      end
    end

    context "for signed in users" do
      it_behaves_like "require_signed_out" do
        let(:verb_action) { get :new }
      end
    end
  end

  describe "GET create" do
    context "for a user with a forgotten password" do
      context "for signed out users" do
        context "for blank input" do
          let(:joe) { Fabricate(:user) }
          before    { get :create, { email: "" } }

          it "redirects to the forgot_password page" do
            expect(response).to redirect_to forgot_password_path
          end
          it "flashes notice that email can't be blank" do
            expect(flash[:error]).to_not be_blank
          end
        end

        context "email is found in database" do
          let(:joe) { Fabricate(:user) }
          before    { get :create, { email: joe.email } }

          it "loads the @user instance variable found from the email provided" do
            expect(assigns(:user)).to eq(joe)
          end
          it "creates a new password_reset_token for the user" do
            expect(User.find_by(email: joe.email).password_reset_token).to_not be_blank
          end
          it "redirects to the 'email sent' " do
           expect(response).to redirect_to confirm_password_reset_email_path
          end

          context "email sending" do
            after { ActionMailer::Base.deliveries.clear }

            it "sends an email to the user owner of the email entered" do
              expect(ActionMailer::Base.deliveries.last.to).to eq([joe.email])
            end
            it "contains an address with the token in the url" do
              expect(ActionMailer::Base.deliveries.last.subject).to include("Reset Your MyFLiX Password")
            end
            it "contains an address with the token in the url" do
              expect(ActionMailer::Base.deliveries.last.parts.first.body.raw_source).to include("Reset Your Password")
            end
          end
        end

        context "email is not found in the database" do
          before { get :create, { email: "hacker@email.com" } }

          it "redirects to the forgot_password page if the email address cannot be found" do
            expect(response).to redirect_to forgot_password_path
          end
          it "flashes an error if the email could not be found" do
            expect(flash[:error]).to_not be_blank
          end
        end
      end
    end

    context "for signed in users" do
      it_behaves_like "require_signed_out" do
        let(:verb_action) { get :create }
      end
    end
  end


end
