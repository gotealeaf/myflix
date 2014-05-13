require 'spec_helper'
require 'pry'

describe UsersController do

  describe "GET new" do
    it "sets the @user variable if the user is inauthenticated" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "GET index" do
    it "shows all of the current user's followed users" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      alice.follow!(bob)

      get :index
      expect(alice.followed_users).to eq([bob])
    end
  end

  describe "GET show" do
    it "shows the user's queued videos" do
      alice = Fabricate(:user)
      set_current_user(alice)
      south_park = Fabricate(:video)
      queue_item = Fabricate(:queue_item, video: south_park, user: alice)

      get :show, id: alice.id
      expect(alice.queue_items).to eq([queue_item])
    end
    it "shows the user's reviews" do
      alice = Fabricate(:user)
      set_current_user(alice)
      south_park = Fabricate(:video)
      review =  Fabricate(:review, rating: 3, user: alice, video: south_park )

      get :show, id: alice.id
      expect(alice.reviews).to eq([review])
    end
  end

  describe "POST create" do
    context "successful user sign up" do
      it "redirects to the videos path" do
        result = double(:sign_up_result, successful?: true)
        UserSignup.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user)

        expect(response).to redirect_to videos_path
      end
    end
    context "failed user sign up" do
      it "renders the new template" do
        result = double(:result, successful?: false, error_message: "Your card was declined")
        UserSignup.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '12345'

        expect(response).to render_template(:new)
      end

      it "sets the flash error message" do
        result = double(:charge, successful?: false, error_message: "Your card was declined")
        UserSignup.any_instance.should_receive(:sign_up).and_return(result)
        post :create, user: Fabricate.attributes_for(:user), stripeToken: '12345'

        expect(flash[:error]).to be_present
      end
    end
  end
  describe "GET register_with_token" do 
    it "renders the :new view template" do
      bob = Fabricate(:user)
      invitation = Fabricate(:invitation, guest_email: "alice@example.com", inviter_id: bob.id)
      get :register_with_token, invitation_token: invitation.invitation_token

      expect(response).to render_template(:new)
    end

    it "sets @user with recipients email" do
      bob = Fabricate(:user)
      invitation = Fabricate(:invitation, guest_email: "alice@example.com", inviter_id: bob.id)
      get :register_with_token, invitation_token: invitation.invitation_token

      expect(assigns(:user).email).to eq("alice@example.com")
    end

    it "sets @invitation_token" do
      invitation = Fabricate(:invitation)
      get :register_with_token, invitation_token: invitation.invitation_token

      expect(assigns(:invitation_token)).to eq(invitation.invitation_token)
    end

    it "redirects to expired token page for invalid tokens" do
      bob = Fabricate(:user)
      invitation = Fabricate(:invitation, guest_email: "alice@example.com", inviter_id: bob.id)
      get :register_with_token, invitation_token: '12345'

      expect(response).to redirect_to(expired_token_path)
    end
  end
end

