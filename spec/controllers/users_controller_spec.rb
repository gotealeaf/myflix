require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it_behaves_like "register_authenticated_user" do
      let(:action) { get :new }
    end

    context "with no authenticated user" do
      it "sets @user to a new user" do
        get :new
        expect(assigns(:user)).to be_a_new User
      end
    end
  end


  describe "GET new_from_invitation" do
    it_behaves_like "register_authenticated_user" do
      let(:action) do
        invitation = Fabricate(:invitation)
        get :new_from_invitation, token: invitation.token
      end
    end

    context "with no authenticated user" do
      it "with invalid token redirects to the registration page" do
        get :new_from_invitation, token: 'fake_token'
        expect(response).to redirect_to register_path
      end

      it "with invalid token sets a warning message" do
        get :new_from_invitation, token: 'fake_token'
        expect(flash[:warning]).to_not be_blank
      end

      it "with valid token renders the new template" do
        invitation = Fabricate(:invitation)
        get :new_from_invitation, token: invitation.token
        expect(response).to render_template :new
      end

      it "with valid token sets @user to a new user" do
        invitation = Fabricate(:invitation)
        get :new_from_invitation, token: invitation.token
        expect(assigns(:user)).to be_a_new User
      end

      it "with valid token associates the user with the invitee's name and email" do
        invitation = Fabricate(:invitation)
        get :new_from_invitation, token: invitation.token
        expect(assigns(:user).email).to eq invitation.invitee_email
        expect(assigns(:user).full_name).to eq invitation.invitee_name
      end
    end
  end

  describe "POST create" do
    context "with valid input" do
      before { post :create, user: Fabricate.attributes_for(:user) }
      after { ActionMailer::Base.deliveries = [] }

      it "redirects to sign in" do
        expect(response).to redirect_to sign_in_path
      end

      it "creates the user" do
        expect(User.count).to eq 1
      end
    end

    context "with invalid input" do
      before { post :create, user: Fabricate.attributes_for(:user, password: nil) }
      after { ActionMailer::Base.deliveries = [] }

      it "does not create the user" do
        expect(User.count).to eq 0
      end

      it "renders the new user template" do
        expect(response).to render_template :new
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of User
      end
    end

    context "registration email" do
      after { ActionMailer::Base.deliveries = [] }

      it "sends the email with valid input" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end

      it "sends the email to the user's email address with valid input" do
        post :create, user: Fabricate.attributes_for(:user, email: 'bill@exmpl.com')
        expect(ActionMailer::Base.deliveries.last.to).to eq ['bill@exmpl.com']
      end

      it "contains the user's name in the body with valid input" do
        post :create, user: Fabricate.attributes_for(:user, full_name: 'Wild Bill')
        expect(ActionMailer::Base.deliveries.last.body).to include 'Wild Bill'
      end

      it "does not send an email with invalid input" do
        post :create, user: Fabricate.attributes_for(:user, password: nil)
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end

    context "invited by a user" do
      let(:jane) { Fabricate(:user) }

      before do
        Invitation.create(inviter: jane, invitee_email: 'billy@example.com', invitee_name: 'Billy', message: 'Hi')
        post :create, user: Fabricate.attributes_for(:user, email: 'billy@example.com')
      end

      after { ActionMailer::Base.deliveries = [] }

      it "has the new user follow another user if invited by that user" do
        expect(jane.followers).to include User.find_by_email('billy@example.com')
      end

      it "has a user follow the new user if that user invited her" do
        expect(jane.followees).to include User.find_by_email('billy@example.com')
      end
    end
  end

  describe "GET show" do
    let(:user) { Fabricate(:user) }

    before { set_current_user }

    it_behaves_like "require_sign_in" do
      let(:action) { get :show, id: user.id }
    end

    it "sets @user" do
      get :show, id: user.id
      expect(assigns(:user)).to eq user
    end
  end
end