require 'spec_helper'

describe RelationshipsController  do

  describe "GET index"   do

    it_behaves_like "requires sign in" do
      let(:action) {get :index}
    end

    context "with a current user and a leader" do
      let!(:alice) {Fabricate(:user)}
      before { session[:user_id] = alice.id}
      let!(:leader_bob) {Fabricate(:user)}

      it "should set the @relationships variable" do
        relationship_1 = Fabricate(:relationship, leader: leader_bob, follower: alice)
        get :index
        expect(assigns(:relationships )).to eq([relationship_1])
      end
    end
  end

  describe "POST create" do
    it_behaves_like "requires sign in" do
      let(:action) {post :create, leader: 4}
    end

    context "with a signed in user and a potential leader" do
      let!(:alice) {Fabricate(:user)}
      before { session[:user_id] = alice.id}
      let!(:bob) {Fabricate(:user)}

      it "redirects to the people page" do
        post :create, leader_id: bob.id
        expect(response).to redirect_to people_path
      end
      it "creates a new relationship" do
        post :create, leader_id: bob.id
        expect(Relationship.count).to eq(1)
      end
      it "the current_user becomes the follower" do
        post :create, leader_id: bob.id
        expect(Relationship.first.follower_id).to eq(alice.id)
      end
      it "doesn't allow double following" do
        relationship_1 = Fabricate(:relationship, leader: bob, follower: alice)
       post :create, leader_id: bob.id
        expect(Relationship.count).to eq(1)
      end
      it "doesn't allow following oneself" do
        post :create, leader_id: alice.id
        expect(Relationship.count).to eq(0)
      end
    end
  end

  describe "DELETE destroy" do

    it_behaves_like "requires sign in" do
      let(:action) {get :index}
    end

    context "with a valid relationship" do
      let!(:alice) {Fabricate(:user)}
      before { session[:user_id] = alice.id}
      let!(:bob) {Fabricate(:user)}
      let!(:relationship_1)  {Fabricate(:relationship, leader: bob, follower: alice)}

      it "should redirect to the people page" do
        delete :destroy, id: relationship_1.id
        expect(response).to redirect_to people_path
      end
      it "should delete the relationhip" do
        delete :destroy, id: relationship_1
        expect(Relationship.count).to eq(0)
      end
      it "prevents deletion of other's followers" do
        charlie = Fabricate(:user)
        relationship = Fabricate(:relationship, leader: bob, follower: charlie)
        delete :destroy, id: relationship
        expect(Relationship.count).to eq(2)
      end
    end
  end
end