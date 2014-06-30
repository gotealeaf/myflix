require 'rails_helper'

describe RelationshipsController do
  describe "GET index" do
    it_behaves_like "requires sign in" do
      let(:action) { get :index }
    end

    it "sets @relationships to current user's following relationships" do
      joe = Fabricate(:user)
      set_current_user(joe)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: joe, leader: bob)
      get :index
      expect(assigns(:relationships)).to eq([relationship])
    end
  end

  describe "DELETE destroy" do
    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, id: 3 }
    end

    it "deletes the relationship if current user is follower" do
      joe = Fabricate(:user)
      set_current_user(joe)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: joe, leader: bob)
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(0)
    end

    it "redirects to people page" do
      joe = Fabricate(:user)
      set_current_user(joe)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: joe, leader: bob)
      delete :destroy, id: relationship
      expect(response).to redirect_to people_path
    end

    it "does not delete the relationship if current user is not follower" do
      joe = Fabricate(:user)
      set_current_user(joe)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: bob, leader: joe)
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(1)
    end
  end
end
