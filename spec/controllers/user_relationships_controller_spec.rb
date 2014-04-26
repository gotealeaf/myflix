require 'spec_helper'

describe UserRelationshipsController do
  before { set_current_user }

  describe "GET index" do
    it_behaves_like "require_sign_in" do
      let(:action) { get :index }
    end

    it "renders the people template" do
      get :index
      expect(response).to render_template 'user_relationships/people'
    end

    it "sets @user_relationships to the followee relationships of the current user" do
      relationship1 = Fabricate(:user_relationship, follower: current_user)
      relationship2 = Fabricate(:user_relationship, follower: current_user)
      get :index
      expect(assigns(:user_relationships)).to match_array [relationship1, relationship2]
    end
  end

  describe "POST create" do
    it_behaves_like "require_sign_in" do
      let(:action) { post :create }
    end

    it "redirects to the people page" do
      post :create, user_id: Fabricate(:user)
      expect(response).to redirect_to people_path
    end

    it "creates a user_relationship with the current user as the follower of the passed user" do
      john = Fabricate(:user)
      post :create, user_id: john.id
      expect(UserRelationship.first.followee).to eq john
    end
  end

  describe "DELETE destroy" do
    it_behaves_like "require_sign_in" do
      let(:action) { delete :destroy, id: Fabricate(:user_relationship) }
    end

    it "redirects to the people page" do
      delete :destroy, id: Fabricate(:user_relationship)
      expect(response).to redirect_to people_path
    end

    it "deletes the user_relationship if the current user is the follower" do
      delete :destroy, id: Fabricate(:user_relationship, follower: current_user)
      expect(UserRelationship.count).to eq 0
    end

    it "does not delete the user_relationship if the current user is not the follower" do
      delete :destroy, id: Fabricate(:user_relationship)
      expect(UserRelationship.count).to eq 1
    end
  end
end