require 'spec_helper'

describe RelationshipsController do
  describe "GET index" do 
    it_behaves_like "require_sign_in" do
      let(:action) { get :index, user_id: 3 }
    end

    it "sets @followed_people" do
      ana = Fabricate :user
      set_current_user ana

      tom = Fabricate :user
      alice = Fabricate :user
      
      relationship1 = Fabricate :relationship, user: tom, follower: ana
      relationship1 = Fabricate :relationship, user: alice, follower: ana

      get :index, user_id: ana.id

      expect(assigns :followed_people).to match_array([tom, alice])
    end
  end
end