require 'spec_helper'

describe RelationshipsController do
  describe "GET index" do
    before do
      alice = Fabricate(:user)
      set_current_user(alice)
      
    end
    let(:alice) { current_user }

    it "sets @relationships to the current user's following relationships" do
      #alice = Fabricate(:user)
      #set_current_user(alice)
      bob = Fabricate(:user)

      relationship = Fabricate(:relationship, follower: alice, leader: bob)
      get :index
      expect(assigns(:relationships)).to eq([relationship])
    end

    it_behaves_like "require_sign_in" do
      let(:action) { get :index }
    end

  end #end GET index

  describe "DELETE destroy" do
    before do
      alice = Fabricate(:user)
      set_current_user(alice)
      
    end
    let(:alice) { current_user }

    it_behaves_like "require_sign_in" do
      let(:action) { delete :destroy, id: 4 }
    end

    it "deletes the relationship of the current user with the leader" do
      bob = Fabricate(:user)

      relationship = Fabricate(:relationship, follower: alice, leader: bob)
      delete :destroy, id: relationship.id
      expect(Relationship.count).to eq(0)
    end

    it "redirects back to people page following_relationships" do
    bob = Fabricate(:user)

      relationship = Fabricate(:relationship, follower: alice, leader: bob)
      delete :destroy, id: relationship.id
      expect(response).to redirect_to people_path
    end
    it "does not delete the relationship if the current user is not the follower" do

       bob = Fabricate(:user)
       raj = Fabricate(:user)
       

      relationship = Fabricate(:relationship, follower: raj, leader: bob)
      delete :destroy, id: relationship.id
      expect(Relationship.count).to eq(1)


    end
    
  end #end DELETE destroy

  describe "POST create" do
    before do
      alice = Fabricate(:user)
      set_current_user(alice)
      
    end
    let(:alice) { current_user }

    it_behaves_like "require_sign_in" do
      let(:action) { post :create, id: 4 }
    end

    it "creates a relationship between current user and leader" do
       bob = Fabricate(:user)
       
      post :create, leader_id: bob.id
      expect(alice.following_relationships.first.leader).to eq(bob)

    end

    it "redirects to the people page" do
      bob = Fabricate(:user)
      post :create, leader_id: bob.id
      expect(response).to redirect_to people_path

    end

    it "makes sure that current user cannot follow a leader more than once" do
      bob = Fabricate(:user)

      relationship = Fabricate(:relationship, follower: alice, leader: bob)
      post :create, leader_id: bob.id
      expect(Relationship.count).to eq(1)
    
    end  

    it "does not allow one to follow itself" do
      
      post :create, leader_id: alice.id

      expect(Relationship.count).to eq(0)
    
    end
  end #POST create

end
