require 'spec_helper'

describe RelationshipsController do
  
  describe "GET Index" do
    it "should set @relationship as the current user's following relationships (ie: where the user is following others)" do
      jane = Fabricate(:user)
      set_current_user(jane)
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, leader: bob, follower: jane)
      get :index
      expect(assigns(:relationships)).to eq([relationship])
    end
      
    it_behaves_like "require sign in" do
      let(:action) { get :index }
    end
  end #ends GET Index
  
  describe "DELETE Destroy" do
    
    it_behaves_like "require sign in" do
      let(:action) { delete :destroy, id: 3 }
    end
    
    context "signed in user" do    
      let(:jane) { Fabricate(:user) }
      let(:bob) { Fabricate(:user) } 
      before do
        set_current_user(jane)
      end
      
      it 'should delete the relationship if the current user is the follower of the relationship' do
        relationship = Fabricate(:relationship, leader: bob, follower: jane)
        delete :destroy, id: relationship.id
        expect(Relationship.count).to eq(0)
      end
      
      it 'should not delete the relationship if the current user is not the follower of the relationship' do
        james = Fabricate(:user)
        relationship = Fabricate(:relationship, leader: bob, follower: james) #note the difference
        delete :destroy, id: relationship.id
        expect(Relationship.count).to eq(1)
      end

      it 'redirects to the people page after the relationship is deleted' do
        relationship = Fabricate(:relationship, leader: bob, follower: jane)
        delete :destroy, id: relationship.id
        expect(response).to redirect_to people_path
      end

      it 'should display a flash message confirming that the relationship is deleted' do
        relationship = Fabricate(:relationship, leader: bob, follower: jane)
        delete :destroy, id: relationship.id
        expect(flash[:danger]).not_to be_blank
      end
    end
  end #ends DELETE destroy
  
  describe "POST create" do
    
    it_behaves_like "require sign in" do
        let(:action) { post :create }
      end
    
    context "signed in user" do
      
      let(:jane) { Fabricate(:user) }
      let(:bob) { Fabricate(:user) } 
      before do
        set_current_user(jane)
      end
      
      it 'should create a relationship between the current_user and the person being followed (ie: the leader)' do
        post :create, leader_id: bob.id
        expect(jane.following_relationships.first.leader).to eq(bob)
      end
      
      it 'should redirect to the people page' do
        post :create, leader_id: bob.id
        expect(response).to redirect_to people_path
      end
      
      it 'should display a flash message if relationship could be created' do
        post :create, leader_id: bob.id
        expect(flash[:success]).not_to be_blank
      end
      
      it 'should not allow a user to follow themselves' do
        post :create, leader_id: jane.id
        expect(Relationship.count).to eq(0)
      end
      
      it 'should not allow the current user to create a relationship with the same user more than once' do
        relationship = Fabricate(:relationship, leader: bob, follower: jane)
        post :create, leader_id: bob.id
        expect(Relationship.count).to eq(1) #just the one above
      end
    end #ends signed in user context
  end #ends POST create
end