require "rails_helper"

describe RelationshipsController do
  describe "GET index" do
    it_behaves_like "require sign in" do
      let(:action) { get :index }
    end

    it "sets @relationships to the current user's following relationships" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: alice, leader: bob)

      get :index

      expect(assigns(:relationships)).to eq([relationship])
    end
  end #GET index

  describe "DELETE destroy" do
    it_behaves_like "require sign in" do
      let(:action) { delete :destroy, id: 4 }
    end

    it "redirects to the people page" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: alice, leader: bob)

      delete :destroy, id: relationship

      expect(response).to redirect_to people_path
    end

    it "deletes the relationship if the current user is the follower" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: alice, leader: bob)

      delete :destroy, id: relationship

      expect(Relationship.count).to eq(0)
    end
    
    it "does not delete the relationship if the current user is not the follower" do
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      condor = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: condor, leader: bob)

      delete :destroy, id: relationship

      expect(Relationship.count).to eq(1)
    end
  end #DELETE destroy
end