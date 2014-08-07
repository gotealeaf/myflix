require 'spec_helper'

describe UsersController do

  let(:current_user) { Fabricate(:user) }
  let(:another_user) { Fabricate(:user) }

  describe "GET show" do

    before { session[:user_id] = current_user.id }

    it "assigns @user" do
      get :show, id: current_user
      expect(assigns(:user)).to eq(current_user)
    end

    it "renders template :show" do
      get :show, id: current_user
      expect(response).to render_template :show
    end
  end

  describe "GET new" do

    it "assigns @user" do
      get :new
      expect(assigns(:user)).to be_new_record
      expect(assigns(:user)).to be_instance_of(User)
    end

    it "renders template :new" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "GET new_with_invite" do
    let(:invitation) { Fabricate(:invitation) }

    context "valid token" do
      before { get :new_with_invite, token: invitation.token }

      it "assigns @user with recipient email" do
        expect(assigns(:user).email).to eq(invitation.recipient_email)
      end

      it "render :new template" do
        expect(response).to render_template :new
      end

      it "assigns @invitation_token" do
        expect(assigns(:invitation_token)).to eq(invitation.token)
      end
    end


    it_behaves_like "invalid token expired" do
      let(:action) { get :new_with_invite, token: "123123" }
    end
  end


  describe "POST create" do

    context "valid attributes" do

      before { post :create, user: Fabricate.attributes_for(:user) }
      after { ActionMailer::Base.deliveries.clear }

      it "creates a new user record" do
        expect {
          post :create, user: Fabricate.attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "redirects to root path" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to root_path
      end

      it "sends out a email" do
        expect(ActionMailer::Base.deliveries).not_to be_empty
      end

      it "sends to to right user" do
        expect(ActionMailer::Base.deliveries.last.to).to eq([User.last.email])
      end

      context "with invitation_token" do
        let(:inv) { Fabricate(:invitation, inviter_id: current_user.id) }
        before { post :create, user: { full_name: inv.recipient_name, email: inv.recipient_email, password: "00001111",
           password_confirmation:"00001111"}, invitation_token: inv.token }

        it "creates a new user record" do
          expect(User.last.email).to eq(inv.recipient_email)
        end

        it "inviter follow recipient" do
          expect(current_user.following?(User.last)).to be true
        end

        it "inviter follow recipient" do
          expect(User.last.following?(current_user)).to be true
        end

        it "expires the token with @use.save" do
          expect(Invitation.first.token).to eq nil
        end
      end
    end

    context "invalid attributes" do

      before { Fabricate(:user, email:"example@example.com") }
      after { ActionMailer::Base.deliveries.clear }

      it "dont create a new user record" do
        expect {
          post :create, user: Fabricate.attributes_for(:user, email: "example@example.com")
        }.not_to change(User, :count)
      end

      it "dont send out email" do
        expect(ActionMailer::Base.deliveries).to be_empty
      end

      before { post :create, user: Fabricate.attributes_for(:user, email: "example@example.com") }

      it "renders template :new" do
        expect(response).to render_template :new
      end

      it "assigns @user" do
        expect(assigns(:user)).to be_new_record
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end


  # describe "PUT update" do
  #
  #   let(:user) { Fabricate(:user, email: "Lawrence@example.com", full_name:"KK Smith") }
  #   before { session[:user_id] = user.id }
  #
  #   context "valid attributes" do
  #     it "locate requested @user" do
  #       put :edit, id: user
  #       expect(assigns(:user)).to eq(user)
  #     end
  #
  #     it "change @user' attributes" do
  #       put :update, id: user.slug, user: Fabricate.attributes_for(:user, email: "marisa@becker.com", full_name: "Brianne Mraz")
  #       user.reload
  #       expect(user.email).to eq("marisa@becker.com")
  #     end
  #   end
  # end
  #
  # describe "GET following" do
  #
  #   before do
  #     session[:user_id] = current_user.id
  #     Fabricate(:relationship, follower: current_user, followed: another_user)
  #     get :following
  #   end
  #
  #   it "assigns @followed_users" do
  #     expect(assigns(:followed_users)).to eq([another_user])
  #   end
  #
  #   it "renders template :following" do
  #     expect(response).to render_template :following
  #   end
  # end
end
