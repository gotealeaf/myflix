require 'spec_helper'

describe RelationshipsController do 
  describe "GET index" do 
    it "sets @relationshios to the current users followers" do 
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: alice, leader: bob)
      get :index
      expect(assigns(:relationships)).to eq([relationship])
    end
    it_behaves_like "requires sign in" do 
      let(:action) { get :index }
    end
  end 

  describe "DELETE destroyer" do 
    it_behaves_like "requires sign in" do 
      let(:action) { delete :destroy, id: 4}
    end
    it "deletes the relationship if the current user is the follower" do 
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: alice, leader: bob)
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(0)
    end
    it "redirects to the people page" do 
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: alice, leader: bob)
      delete :destroy, id: relationship
      expect(response).to redirect_to people_path
    end
    it "does not delete the relationship if the current user is not the follower" do 
      alice = Fabricate(:user)
      set_current_user(alice)
      bob = Fabricate(:user)
      charlie = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: charlie, leader: bob)
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(1)
    end

  end
end