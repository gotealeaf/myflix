require 'spec_helper'

describe PasswordResetsController do

  describe "GET show" do
    context "with a valid token" do
      let(:joe) { Fabricate(:user) }
      before do
        joe.update_columns(prt_created_at: 2.minutes.ago)
        get :show, id: joe.token
      end

      it "renders the reset password page" do
        expect(response).to render_template "show"
      end
      it "assigns the @token instance variable" do
        expect(assigns(:token)).to eq(joe.token)
      end
      it "assigns the @user instance variable" do
        expect(assigns(:user)).to eq(joe)
      end
    end

    context "with an invalid expired token" do
      let(:joe) { Fabricate(:user) }
      before { get :show, id: joe.token }

      it "redirects to the expired token page" do
        expect(response).to redirect_to expired_token_path
      end
    end

    context "with an invalid wrong token" do
      before { get :show, id: "12345" }

      context "if token does not exist" do
        it "redirects to the root path" do
          expect(response).to redirect_to root_path
        end
      end
    end
  end

  describe "POST create" do
    let(:joe) { Fabricate(:user) }

    context "with valid token" do
      context "with valid password" do
        before do
          joe.update_columns(prt_created_at: 2.minutes.ago)
          post :create, { token: joe.token, password: "new_password" }
        end

        it "loads the @user instance variable" do
          expect(assigns(:user)).to eq(joe)
        end
        it "saves the users new password into the database" do
          expect(joe.reload.authenticate("new_password")).to be_true
        end
        it "flashes a success message" do
          expect(flash[:notice]).to_not be_blank
        end
        it "redirects the user to the signin page" do
          expect(response).to redirect_to signin_path
        end
        it "clears the user's token"
      end

      context "with invalid password" do
        before do
          joe.update_columns(prt_created_at: 2.minutes.ago)
          post :create, { token: joe.token, password: "" }
        end
        it "rejects invalid passwords" do
          expect(response).to redirect_to password_reset_path(joe.token)
        end
      end
    end

    context "with invalid token" do
      context "due to changed token value" do
        before { post :create, { token: "123456", password: "password" } }

        it "redirects the hacker to the root path" do
          expect(response).to redirect_to root_path
        end
      end

      context "due to token too old" do
        let(:joe) { Fabricate(:user) }
        before { post :create, { token: joe.token, password: "new_password" } }

        it "resets the token to nil" do
          old_token = joe.token
          expect(joe.reload.token).to_not eq(old_token)
        end
        it "redirects the user to the expired tokens page" do
          expect(response).to redirect_to expired_token_path
        end
      end
    end
  end
end
