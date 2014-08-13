require "spec_helper"

describe PasswordResetsController do
  describe "POST create" do
    context "with blank input" do
      before { post :create, email: "" }

      it "renders the :new template" do
        expect(response).to render_template :new
      end

      it "sends error message" do
        expect(flash[:error]).to_not be_blank
      end
    end

    context "with valid user email" do
      let(:holly) { Fabricate(:user) }
      before { post :create, email: holly.email }

      it "redirects to confirm password reset page" do
        expect(response).to redirect_to confirm_password_reset_path
      end

      context "sending email" do
        after { ActionMailer::Base.deliveries.clear }

        it "sends the password reset email to correct recipient" do
          expect(ActionMailer::Base.deliveries.last.to).to eq([holly.email])
        end

        it "sends the password reset email with correct content" do
          expect(ActionMailer::Base.deliveries.last.body).to include("Reset Password")
        end
      end
    end

    context "with invalid email" do
      let(:holly) { Fabricate(:user) }
      before { post :create, email: "other_user@email.com" }
      after { ActionMailer::Base.deliveries.clear }

      it "does not find a user with entered email" do
        expect(assigns(:user)).to be_nil
      end

      it "does not send the email" do
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end

  describe "GET edit" do
    let(:jack) { Fabricate(:user) }
    before { set_current_user}

    context "with valid password reset token" do
      before { get :edit, id: jack.token }

      it "assigns the @user variable" do
        expect(assigns(:user)).to eq(jack)
      end

      it "renders the show template" do
        expect(response).to render_template :edit
      end
    end

    context "with invalid token" do
      it "redirects to the expired token page" do
        get :edit, id: "12345"
        expect(response).to redirect_to expired_token_path
      end
    end
  end

  describe "PATCH update" do
    let(:erica) { Fabricate(:user, token: "12345") }

    context "with valid password" do
      before { patch :update, id: erica.token, user: { password: "catsrule" } }

      it "redirects to the login page" do
        expect(response).to redirect_to login_path
      end

      it "updates the user's password" do
        expect(erica.reload.authenticate("catsrule")).to be_true
      end

      it "sets the flash notice" do
        expect(flash[:notice]).to_not be_empty
      end

      it "regenerates the reset password token" do
        expect(erica.reload.token).to_not eq("12345")
      end
    end

    context "with invalid password" do
      it "renders the :edit template" do
        patch :update, id: erica.token, user: { password: "cats" }
        expect(response).to render_template :edit
      end
    end
  end
end





