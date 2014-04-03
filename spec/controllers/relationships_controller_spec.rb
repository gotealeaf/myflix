require 'spec_helper'

describe RelationshipsController do
  describe "POST create" do
    it "redirects to the people page" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)

      post :create, relationship: {user_id: bob.id}, user_id: bob.id
      expect(response).to redirect_to users_path
    end
    it "creates a followed user" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)

      post :create, relationship: {user_id: bob.id}, user_id: bob.id
      expect(alice.following?(bob)).to be_true
    end
    it "creates a followed user for the current user" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)

      post :create, relationship: {user_id: bob.id}, user_id: bob.id
      expect(alice.following?(bob)).to be_true
    end

    it "does not create a followed user if current user is already following the user" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      alice.follow!(bob)

      post :create, relationship: {user_id: bob.id}, user_id: bob.id
      expect(flash[:notice]).to eq("You are already following this user")
    end
  end

  describe "DELETE destroy" do
    it "redirects to the people page" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      alice.follow!(bob)

      delete :destroy, id: bob.id
      expect(response).to redirect_to(users_path)
    end
    it "removes user from followed users" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      alice.follow!(bob)

      delete :destroy, id: bob.id
      expect(alice.following?(bob)).to be_nil
    end
  end
end