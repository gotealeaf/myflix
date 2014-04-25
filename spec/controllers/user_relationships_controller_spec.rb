require 'spec_helper'

describe UserRelationshipsController do 
  describe "GET index" do
    it_behaves_like "require_sign_in" do
      let(:action) { get :index }
    end

    it "renders the my_people template" do
      set_current_user
      get :index
      expect(response).to render_template 'user_relationships/my_people'
    end

    it "sets @followers to the followers of the current user" do
      set_current_user
      john = Fabricate(:user)
      sandy = Fabricate(:user)
      UserRelationship.create(user: john, follower: current_user )
      UserRelationship.create(user: sandy, follower: current_user)
      get :index
      expect(assigns(:followees)).to match_array [john, sandy]
    end
  end
end